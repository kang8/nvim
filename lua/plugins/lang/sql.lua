return {
  'cfmeyers/dbt.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'rcarriga/nvim-notify',
  },
  ft = 'sql',
  keys = {
    { 'gd', '<cmd>DBTGoToDefinition<cr>', mode = { 'n' } },
  },
}
