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
        Comment = { fg = '#949494' },
        GitSignsCurrentLineBlame = { fg = '#b7b7b7' },
      },
    },
  },
}
