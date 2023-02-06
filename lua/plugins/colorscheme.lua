return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    init = function()
      vim.cmd.colorscheme('catppuccin-latte')
    end,
  },
}
