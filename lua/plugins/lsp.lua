vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.api.nvim_create_user_command('Rename', function()
      vim.lsp.buf.rename()
    end, {})

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    assert(client) -- check client is not nil
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(args.buf, true)
    end
  end,
})

return {
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        'j-hui/fidget.nvim',
        event = 'LspAttach',
        opts = {},
      },
    },
    keys = {
      { '<leader>cd', vim.diagnostic.open_float, desc = 'Line Diagnostics' },
      { '<leader>cl', '<cmd>LspInfo<cr>', desc = 'Lsp Info' },
      { 'gd', vim.lsp.buf.definition, desc = 'Goto Definition' },
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
      -- personal preference
      { '<F2>', vim.lsp.buf.rename, desc = 'Rename' },
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
              },
              completion = {
                callSnippet = 'Replace',
              },
              hint = {
                enable = true,
                arrayIndex = 'Disable',
              },
            },
          },
        },
        tsserver = {
          single_file_support = false,
          root_dir = require('lspconfig').util.root_pattern('package.json'),
          settings = {
            typescript = {
              inlayHints = {
                -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true, -- false
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true, -- false
              },
            },
            javascript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              },
            },
          },
        },
        denols = {
          root_dir = require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc'),
        },
        clangd = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        gopls = {},
      }

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
          nls.builtins.formatting.deno_fmt,
          nls.builtins.formatting.clang_format,
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
        'clang-format',
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
  {
    'Wansmer/symbol-usage.nvim',
    event = 'BufReadPre', -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
    opts = {
      vt_position = 'end_of_line',
    },
  },
}
