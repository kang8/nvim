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
        'git: Toggle git diff',
      },
    },
  },
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-git',
    },
    config = function()
      vim.keymap.set('n', '<F18>', function() -- <F18> is cmd + G
        local left_win = vim.fn.winnr() - 1

        if 'fugitiveblame' == vim.bo.filetype then
          vim.api.nvim_win_close(vim.api.nvim_get_current_win(), true)
        elseif
          left_win > 0 and 'fugitiveblame' == vim.bo[vim.api.nvim_win_get_buf(vim.fn.win_getid(left_win))].filetype
        then
          vim.api.nvim_win_close(vim.fn.win_getid(left_win), true)
        else
          vim.cmd('Git blame')
        end
      end, { desc = 'git: Toggle git blame' })
    end,
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
