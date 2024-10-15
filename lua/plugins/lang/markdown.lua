return {
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    opts = {
      heading = {
        -- Width of the heading background:
        --  block: width of the heading text
        --  full:  full width of the window
        -- Can also be a list of the above values in which case the 'level' is used
        -- to index into the list using a clamp
        width = 'block',
      },
      sign = {
        enabled = false,
      },
    },
  },
}
