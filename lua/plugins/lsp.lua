vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }

    -- Navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = 'Goto Definition' }))
    vim.keymap.set(
      'n',
      'gr',
      '<cmd>Telescope lsp_references<cr>',
      vim.tbl_extend('force', opts, { desc = 'References' })
    )
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = 'Goto Declaration' }))
    vim.keymap.set(
      'n',
      'gI',
      '<cmd>Telescope lsp_implementations<cr>',
      vim.tbl_extend('force', opts, { desc = 'Goto Implementation' })
    )
    vim.keymap.set(
      'n',
      'gt',
      '<cmd>Telescope lsp_type_definitions<cr>',
      vim.tbl_extend('force', opts, { desc = 'Goto Type Definition' })
    )
    vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Help' }))

    -- Diagnostics
    vim.keymap.set(
      'n',
      '<leader>cd',
      vim.diagnostic.open_float,
      vim.tbl_extend('force', opts, { desc = 'Line Diagnostics' })
    )
    vim.keymap.set('n', '<c-j>', vim.diagnostic.goto_next, vim.tbl_extend('force', opts, { desc = 'Next Diagnostic' }))
    vim.keymap.set('n', '<c-k>', vim.diagnostic.goto_prev, vim.tbl_extend('force', opts, { desc = 'Prev Diagnostic' }))

    -- Code actions
    vim.keymap.set(
      { 'n', 'v' },
      '<leader>ca',
      vim.lsp.buf.code_action,
      vim.tbl_extend('force', opts, { desc = 'Code Action' })
    )
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename' }))
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Rename' }))

    -- Document symbols
    vim.keymap.set('n', '<C-S-R>', function()
      require('telescope.builtin').lsp_document_symbols()
    end, vim.tbl_extend('force', opts, { desc = 'Document Symbols' }))

    -- Signature help in insert mode
    vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', opts, { desc = 'Signature Help' }))

    -- LSP info
    vim.keymap.set('n', '<leader>cl', function()
      vim.notify(vim.inspect(vim.lsp.get_clients({ bufnr = 0 })))
    end, vim.tbl_extend('force', opts, { desc = 'LSP Info' }))

    -- User command for rename
    vim.api.nvim_create_user_command('Rename', function()
      vim.lsp.buf.rename()
    end, {})

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    assert(client) -- check client is not nil
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end

    vim.lsp.document_color.enable(true, args.buf, { style = 'virtual' })
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
    opts = {},
  },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
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
