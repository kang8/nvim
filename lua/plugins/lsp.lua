-- Enable all LSP configurations from lsp/*.lua
local servers = {}
for _, config_path in ipairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
  local server_name = vim.fn.fnamemodify(config_path, ':t:r')
  table.insert(servers, server_name)
end

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', opts, { desc = desc }))
    end

    -- Navigation
    map('n', 'gd', vim.lsp.buf.definition, 'Goto Definition')
    map('n', 'gr', '<cmd>Telescope lsp_references<cr>', 'References')
    map('n', 'gD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('n', 'gI', '<cmd>Telescope lsp_implementations<cr>', 'Goto Implementation')
    map('n', 'gt', '<cmd>Telescope lsp_type_definitions<cr>', 'Goto Type Definition')

    -- Diagnostics
    map('n', '<c-j>', function()
      vim.diagnostic.jump({ count = vim.v.count1 })
    end, 'Next Diagnostic')
    map('n', '<c-k>', function()
      vim.diagnostic.jump({ count = -vim.v.count1 })
    end, 'Prev Diagnostic')

    -- Code actions
    map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
    map('n', '<F2>', vim.lsp.buf.rename, 'Rename')
    vim.api.nvim_create_user_command('Rename', function()
      vim.lsp.buf.rename()
    end, {})

    -- Document symbols
    map('n', '<C-S-R>', function()
      require('telescope.builtin').lsp_document_symbols()
    end, 'Document Symbols')

    -- Signature help in insert mode
    map('i', '<c-k>', vim.lsp.buf.signature_help, 'Signature Help')

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Inlay hints
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true)
    end

    -- Document colors
    vim.lsp.document_color.enable(true, { bufnr = args.buf }, { style = 'background' })

    -- Code lens
    if client:supports_method('textDocument/codeLens') then
      vim.lsp.codelens.enable(true)
    end

    -- LSP folding (prefer over treesitter when available)
    if client:supports_method('textDocument/foldingRange') then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- Linked editing (e.g., auto-rename HTML tags)
    if vim.lsp.linked_editing_range and client:supports_method('textDocument/linkedEditingRange') then
      vim.lsp.linked_editing_range.enable(true)
    end
  end,
})

return {
  {
    'mason-org/mason.nvim',
    opts = {},
  },
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      ensure_installed = servers,
    },
  },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- Need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    opts = {
      vt_position = 'end_of_line',
    },
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
    config = function(_, opts)
      require('conform').setup(opts)

      vim.api.nvim_create_user_command('Format', function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ['end'] = { args.line2, end_line:len() },
          }
        end
        require('conform').format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  },
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        lua = { 'luacheck' },
      }

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('lint', { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
