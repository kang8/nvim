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
    'phaazon/hop.nvim',
    lazy = true,
    branch = 'v2',
    event = 'BufReadPost',
    keys = {
      { '<leader>w', '<cmd>HopWord<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto word' },
      { '<leader>j', '<cmd>HopLine<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto line' },
      { '<leader>k', '<cmd>HopLine<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto line' },
      { '<leader>f', '<cmd>HopChar1<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto one char' },
      { '<leader>ff', '<cmd>HopChar2<cr>', mode = { 'n', 'x' }, desc = 'jump: Goto two char' },
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
    'nathom/filetype.nvim',
    enabled = function()
      if vim.fn.expand('%:e') == 'sql' then
        return false
      end

      return true
    end,
  },
}
