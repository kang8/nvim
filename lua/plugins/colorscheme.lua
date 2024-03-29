return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    init = function()
      vim.cmd.colorscheme('catppuccin-latte')
    end,
    opts = {
      integrations = {
        mini = true,
        illuminate = true,
        dropbar = { enabled = true, color_mode = true },
      },
      custom_highlights = {
        MiniTablineCurrent = { link = 'lualine_a_normal' },
        TabLineSel = { link = 'lualine_a_normal' }, -- MiniTablineCurrent default link to TabLineSel
        MiniTablineModifiedCurrent = { link = 'lualine_a_normal' },
      },
    },
  },
}
