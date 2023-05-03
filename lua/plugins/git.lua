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
    keys = {
      {
        [[\g]],
        function()
          require('gitsigns.actions').toggle_linehl()
          require('gitsigns.actions').toggle_word_diff()
          local is_set = require('gitsigns.actions').toggle_deleted()

          if is_set then
            print('  git diff')
          else
            print('nogit diff')
          end
        end,
        'Toggle git diff',
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
  {
    'tyru/open-browser-github.vim',
    cmd = 'OpenGithubIssue',
    dependencies = {
      'tyru/open-browser.vim',
    },
  },
}
