return {
  {
    'echasnovski/mini.basics',
    event = 'VeryLazy',
    config = function()
      require('mini.basics').setup({
        options = {
          extra_ui = true,
        },
        mappings = {
          basic = false,
        },
      })
    end,
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    config = function()
      require('mini.pairs').setup({})
    end,
  },
  {
    {
      'okuuva/auto-save.nvim',
      cmd = { '' },
      event = { 'InsertLeave', 'TextChanged' },
      opts = {
        debounce_delay = 500,
        condition = function(buf)
          local utils = require('auto-save.utils.data')

          if utils.not_in(vim.fn.getbufvar(buf, '&filetype'), { 'COMMIT_EDITMSG' }) then
            return true
          end
          return false
        end,
      },
    },
  },
  {
    'kang8/smartim',
    event = 'VeryLazy',
    config = function()
      vim.g.smartim_default = 'com.apple.keylayout.ABC'
    end,
  },
  {
    'lambdalisue/suda.vim',
    cmd = {}, -- Unset 'suda.vim' command
    config = function()
      vim.cmd([[ cnoreabbrev sw w suda://% ]])
    end,
  },
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    opts = {
      delay = 200,
      filetypes_denylist = {
        'NvimTree',
        'lazy',
        'dropbar_menu',
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
    -- stylua: ignore
    keys = {
      { ']]', function() require('illuminate').goto_next_reference(false) end, desc = 'Next Reference', },
      { '[[', function() require('illuminate').goto_prev_reference(false) end, desc = 'Prev Reference', },
    },
  },
  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  {
    'nacro90/numb.nvim',
    event = 'VeryLazy',
    config = true,
  },
  {
    'akinsho/toggleterm.nvim',
    event = 'BufReadPost',
    keys = {
      { '<Esc>', [[<C-\><C-n>]], mode = { 'n', 'i' } },
      { '<D-j>', '<cmd>ToggleTerm direction=float<cr>', mode = { 'n', 't' } },
      {
        '<leader>lg',
        function()
          local lazygit = require('toggleterm.terminal').Terminal:new({
            cmd = 'lazygit --use-config-file=${HOME}/.config/lazygit/config.yml',
            hidden = true,
            direction = 'float',
            float_opts = {
              border = 'none',
            },
            on_open = function(_)
              vim.cmd('startinsert!')
            end,
            on_close = function(_) end,
            count = 99,
          })

          lazygit:toggle()
        end,
      },
    },
    config = true,
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      signs = false, -- show icons in the signs column
    },
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    },
  },
  {
    'smoka7/hop.nvim',
    lazy = true,
    version = '*',
    event = { 'CursorHold', 'CursorHoldI' },
    keys = {
      { '<leader>w', '<cmd>HopWordMW<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto word' },
      { '<leader>j', '<cmd>HopLineMW<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto line' },
      { '<leader>k', '<cmd>HopLineMW<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto line' },
      { '<leader>f', '<cmd>HopChar1MW<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto one char' },
    },
    config = true,
  },
  {
    'Pocco81/true-zen.nvim',
    cmd = 'TZFocus',
    keys = {
      { '<leader>zf', '<cmd>TZFocus<CR>', mode = { 'n' }, desc = 'Toggle focus mode' },
    },
    config = true,
  },
  {
    'tzachar/highlight-undo.nvim',
    event = 'BufReadPost',
    config = true,
  },
  {
    'Aasim-A/scrollEOF.nvim',
    event = 'CursorMoved',
    opts = true,
  },
  {
    'yorickpeterse/nvim-window',
    keys = {
      {
        '<c-t>',
        function()
          require('nvim-window').pick()
        end,
        mode = { 'n' },
        desc = 'windown: pick window',
      },
    },
    opts = {
      chars = { 'h', 'j', 'k', 'l', 'g', 's', 'a', 'd' },
    },
  },
  {
    'mrjones2014/smart-splits.nvim',
    build = './kitty/install-kittens.bash',
    lazy = false,
    opts = {
      at_edge = 'stop',
    },
    config = function(_, opts)
      require('smart-splits').setup(opts)

      -- stylua: ignore start
      vim.keymap.set('n', '<A-j>', require('smart-splits').move_cursor_down, { desc = 'window: Move cursor to the DOWN adjacent window' })
      vim.keymap.set('n', '<A-k>', require('smart-splits').move_cursor_up, { desc = 'window: Move cursor to the UP adjacent window' })
      vim.keymap.set('n', '<A-l>', require('smart-splits').move_cursor_right, { desc = 'window: Move cursor to the RIGHT adjacent window' })
      vim.keymap.set('n', '<A-h>', require('smart-splits').move_cursor_left, { desc = 'window: Move cursor to the LEFT adjacent window' })
      vim.keymap.set('n', '<C-A-j>', require('smart-splits').resize_down, { desc = 'window: Resize current window DOWN' })
      vim.keymap.set('n', '<C-A-k>', require('smart-splits').resize_up, { desc = 'window: Resize current window UP' })
      vim.keymap.set('n', '<C-A-h>', require('smart-splits').resize_left, { desc = 'window: Resize current window LEFT' })
      vim.keymap.set('n', '<C-A-l>', require('smart-splits').resize_right, { desc = 'window: Resize current window RIGHT' })
      -- stylua: ignore end
    end,
  },
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {
      disable_mouse = false,
      max_count = 10,
      hints = {
        ['[dcyvV][ia][%(%)]'] = {
          message = function(keys)
            return 'Use ' .. keys:sub(1, 2) .. 'b instead of ' .. keys
          end,
          length = 3,
        },
      },
      restricted_keys = {
        ['j'] = {},
        ['k'] = {},
      },
    },
  },
  {
    'NStefan002/visual-surround.nvim',
    config = true,
  },
  {
    'junegunn/vim-easy-align',
    event = 'VeryLazy',
    config = function()
      -- don't use keys property, because is will lazy do
      vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')
    end,
  },
  {
    'cbochs/portal.nvim',
    keys = {
      { '<leader>i', '<cmd>Portal jumplist forward<cr>', desc = 'Portal: Jump Forward' },
      { '<leader>o', '<cmd>Portal jumplist backward<cr>', desc = 'Portal: Jump Backward' },
    },
  },
  {
    'chrisgrieser/nvim-spider',
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
    },
  },
}
