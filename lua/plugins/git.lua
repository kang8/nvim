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
          require('gitsigns').toggle_linehl()
          require('gitsigns').toggle_word_diff()
          local is_set = require('gitsigns').toggle_deleted()

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
      vim.keymap.set('n', '<D-g>', function()
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

      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Set buffer-local options for fugitive blame buffers.',
        group = vim.api.nvim_create_augroup('FugitiveSettings', {}),
        pattern = 'fugitiveblame',
        callback = function()
          local win_alt = vim.fn.win_getid(vim.fn.winnr('#')) -- last accessed window
          vim.opt_local.winbar = vim.api.nvim_win_is_valid(win_alt) and vim.wo[win_alt].winbar ~= '' and 'FugitiveBlame'
            or ''
        end,
      })
    end,
  },
  {
    'ruanyl/vim-gh-line',
    keys = {
      { '<leader>gh', mode = { 'n', 'x' }, desc = 'git: Open in browser with remote link' },
    },
  },
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewFileHistory',
      'DiffviewOpen',
    },
    keys = {
      { '<leader>gl', '<cmd>DiffviewFileHistory %<cr>', desc = 'git: [N] View git history on current file' },
      {
        '<leader>gl',
        function()
          local visual_range = { vim.fn.line('.'), vim.fn.line('v') }
          table.sort(visual_range)
          vim.cmd(('%d,%d'):format(unpack(visual_range)) .. 'DiffviewFileHistory')
        end,
        mode = 'x',
        desc = 'git: [V] View git history on current file',
      },
    },
    opts = {
      file_history_panel = {
        log_options = {
          git = {
            no_merges = true,
          },
        },
      },
    },
  },
  {
    'yutkat/git-rebase-auto-diff.nvim',
    ft = { 'gitrebase' },
    config = function()
      require('git-rebase-auto-diff').setup()
    end,
  },
}
