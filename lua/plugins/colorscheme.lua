return {
  {
    'catppuccin/nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    name = 'catppuccin',
    init = function()
      vim.cmd.colorscheme('catppuccin-latte')
    end,
    opts = {
      auto_integrations = true, -- auto-detect installed plugins and enable their integrations (gitsigns/nvimtree/illuminate, etc.)
      integrations = {
        -- kept explicit: not picked up by auto_integrations (dropbar also needs custom color_mode)
        mini = true,
        dropbar = { enabled = true, color_mode = true },
      },
      transparent_background = true,
      custom_highlights = {
        MiniTablineCurrent = { link = 'lualine_a_normal' },
        TabLineSel = { link = 'lualine_a_normal' }, -- MiniTablineCurrent default link to TabLineSel
        MiniTablineModifiedCurrent = { link = 'lualine_a_normal' },
        MiniTablineVisible = { link = 'lualine_a_inactive' },
        NonText = { fg = '#d20f3a' },
        GitSignsChangeLn = { link = 'GitSignsAddLn' },
        Folded = { bg = '#bcc0cc', italic = true }, -- latte surface1: make closed folds stand out
      },
    },
  },
}
