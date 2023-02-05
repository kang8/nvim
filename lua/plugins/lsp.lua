vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.cmd([[ command! Rename :lua vim.lsp.buf.rename() ]])
  end,
})

return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      { 'folke/neodev.nvim', opts = { experimental = { pathStrict = true } } },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
        'hrsh7th/cmp-nvim-lsp',
      },
    },
    keys = {
      { '<leader>cd', vim.diagnostic.open_float, desc = 'Line Diagnostics' },
      { '<leader>cl', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
      { 'gd', '<cmd>Telescope lsp_definitions<cr>', desc = 'Goto Definition' },
      { 'gr', '<cmd>Telescope lsp_references<cr>', desc = 'References' },
      { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
      { 'gI', '<cmd>Telescope lsp_implementations<cr>', desc = 'Goto Implementation' },
      { 'gt', '<cmd>Telescope lsp_type_definitions<cr>', desc = 'Goto Type Definition' },
      { 'K', vim.lsp.buf.hover, desc = 'Hover' },
      { 'gK', vim.lsp.buf.signature_help, desc = 'Signature Help' },
      { '<c-k>', vim.lsp.buf.signature_help, mode = 'i', desc = 'Signature Help' },
      { '<c-j>', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },
      { '<c-k>', vim.diagnostic.goto_prev, desc = 'Prev Diagnostic' },
      { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' } },
      { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename' },
    },
    opts = {
      servers = {
        sumneko_lua = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        tsserver = {},
        clangd = {},
      },
    },
    config = function(_, opts)
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local servers = opts.servers

      local function setup(server)
        local server_opts = servers[server] or {}
        server_opts.capabilities = capabilities
        require('lspconfig')[server].setup(server_opts)
      end

      local mlsp = require('mason-lspconfig')
      local ensure_installed = {}

      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.mason == false or not vim.tbl_contains(mlsp.get_available_servers(), server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      require('mason-lspconfig').setup({ ensure_installed = ensure_installed })
      require('mason-lspconfig').setup_handlers({ setup })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'williamboman/mason.nvim' },
    opts = function()
      local nls = require('null-ls')
      return {
        sources = {
          nls.builtins.formatting.stylua,
        },
        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
              vim.lsp.buf.format({ bufnr = bufnr, async = true })
            end, {})

            vim.api.nvim_clear_autocmds({ group = vim.api.nvim_create_augroup('Format', {}), buffer = bufnr })
          end
        end,
      }
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'shfmt',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}