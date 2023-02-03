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
      require('mini.pairs').setup()
    end,
  },
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    config = function()
      require('mini.comment').setup()
    end,
  },
  {
    '907th/vim-auto-save',
    event = 'VeryLazy',
    config = function()
      vim.g.auto_save = true
      vim.g.auto_save_silent = true

      vim.cmd([[
        augroup no_auto_save_file
            au!
            au BufEnter COMMIT_EDITMSG let b:auto_save = 0
        augroup END
      ]])
    end,
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
    event = 'VeryLazy',
    config = function()
      vim.cmd([[ cnoreabbrev sw w suda://% ]])
    end,
  },
  {
    'RRethy/vim-illuminate',
    event = 'BufReadPost',
    opts = { delay = 200 },
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
    'svban/YankAssassin.vim',
    event = 'VeryLazy',
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
    'felipec/vim-sanegx',
    event = 'VeryLazy',
  },
}
