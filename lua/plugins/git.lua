return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    opts = {
      signcolumn = false,
      numhl = true,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 200,
      },
    },
  },
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    dependencies = {
      'tpope/vim-git',
    },
  },
  {
    'ruanyl/vim-gh-line',
    keys = {
      { '<leader>gh' },
    },
  },
}
