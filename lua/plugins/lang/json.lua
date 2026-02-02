return {
  {
    'nvim-treesitter/nvim-treesitter',
    ft = 'json',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'json', 'json5', 'jsonc' })
      end
    end,
  },
  {
    'b0o/schemastore.nvim',
    ft = { 'json', 'jsonc', 'json5' },
  },
}
