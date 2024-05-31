vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.api.nvim_create_user_command('Rename', function()
      vim.lsp.buf.rename()
    end, {})

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    assert(client) -- check client is not nil
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
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
      { 'gK', vim.lsp.buf.signature_help, desc = 'Signature Help' },
      { '<c-k>', vim.lsp.buf.signature_help, mode = 'i', desc = 'Signature Help' },
      { '<c-j>', vim.diagnostic.goto_next, desc = 'Next Diagnostic' },
      { '<c-k>', vim.diagnostic.goto_prev, desc = 'Prev Diagnostic' },
      { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' } },
      {
        '<C-S-R>',
        function()
          require('telescope.builtin').lsp_document_symbols()
        end,
        desc = '[D]ocument [S]ymbols',
      },
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
            completions = {
              completeFunctionCalls = true,
            },
            typescript = {
              inlayHints = {
                -- taken from https://github.com/typescript-language-server/typescript-language-server#workspacedidchangeconfiguration
                includeInlayParameterNameHints = 'literal',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
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
        rust_analyzer = {},
        typos_lsp = {
          -- workaround of exclude_filetypes
          on_attach = function(_, bufnr)
            local exclude_filetypes = { 'help' }

            if vim.tbl_contains(exclude_filetypes, vim.bo.filetype) then
              vim.diagnostic.enable(false, { bufnr = bufnr })
            end
          end,
        },
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
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'shfmt',
        'clang-format',
        'yamlfmt',
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
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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
