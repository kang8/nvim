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
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    config = function()
      require('mini.comment').setup({})
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
    'tyru/open-browser.vim',
    event = 'VeryLazy',
    config = function()
      vim.cmd([[ nmap gx <Plug>(openbrowser-open) ]])
    end,
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
    'ahmedkhalf/project.nvim',
    event = 'VimEnter',
    cmd = 'Telescope projects',
    config = function()
      require('project_nvim').setup({})
    end,
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
      { '<leader>ff', '<cmd>HopChar2MW<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto two char' },
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
    -- stylua: ignore
    keys = {
      { '<A-j>', function() require('smart-splits').move_cursor_down() end, mode = { 'n' }, desc = 'window: Move cursor to DOWN window' },
      { '<A-k>', function() require('smart-splits').move_cursor_up() end, mode = { 'n' }, desc = 'window: Move cursor to UP window' },
      { '<A-h>', function() require('smart-splits').move_cursor_right() end, mode = { 'n' }, desc = 'window: Move cursor to RIGHT window' },
      { '<A-l>', function() require('smart-splits').move_cursor_left() end, mode = { 'n' }, desc = 'window: Move cursor to LEFT window' },
      { '<C-A-j>', function() require('smart-splits').resize_down() end, mode = { 'n' }, desc = 'window: Decrease current window height' },
      { '<C-A-k>', function() require('smart-splits').resize_up() end, mode = { 'n' }, desc = 'window: Increase current window height' },
      { '<C-A-h>', function() require('smart-splits').resize_left() end, mode = { 'n' }, desc = 'window: Increase current window width' },
      { '<C-A-l>', function() require('smart-splits').resize_right() end, mode = { 'n' }, desc = 'window: Decrease current window width' },
    },
  },
  {
    'tpope/vim-sleuth',
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
}
