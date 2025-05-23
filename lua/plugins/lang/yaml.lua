return {
  {
    'nvim-treesitter/nvim-treesitter',
    ft = 'yaml',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'yaml' })
      end
    end,
  },
  {
    'neovim/nvim-lspconfig',
    ft = 'yaml',
    opts = {
      servers = {
        docker_compose_language_service = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    ft = 'yaml',
    opts = function(_, opts)
      if type(opts.formatters_by_ft) == 'table' then
        opts.formatters_by_ft['yaml'] = { 'yamlfmt' }
      end
    end,
  },
  {
    'williamboman/mason.nvim',
    ft = 'yaml',
    opts = {
      ensure_installed = {
        'yamlfmt',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    ft = 'yaml',
    dependencies = {
      'b0o/SchemaStore.nvim',
    },
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              schemas = require('schemastore').yaml.schemas(),
            },
          },
        },
      },
    },
  },
}
