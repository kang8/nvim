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
    'jose-elias-alvarez/null-ls.nvim',
    ft = 'yaml',
    opts = function(_, opts)
      local nls = require('null-ls')
      if type(opts.sources) == 'table' then
        vim.list_extend(opts.sources, { nls.builtins.formatting.yamlfmt })
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
}
