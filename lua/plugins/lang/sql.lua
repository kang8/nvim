return {
  'cfmeyers/dbt.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'rcarriga/nvim-notify',
  },
  ft = 'sql',
  config = function()
    vim.keymap.set('n', 'gd', '<cmd>DBTGoToDefinition<cr>', { desc = 'DBT [G]oto [D]efinition' }) -- typo-ignore:this-line
    vim.keymap.set('n', '<c-]>', '<cmd>DBTGoToDefinition<cr>', { desc = 'DBT [G]oto [D]efinition' }) -- typo-ignore:this-line
  end,
}
