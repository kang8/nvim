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
    'b0o/SchemaStore.nvim',
    ft = 'yaml',
  },
}
