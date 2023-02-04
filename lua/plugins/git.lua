return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = true,
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
