return {
  {
    'echasnovski/mini.nvim',
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

      require('mini.pairs').setup()

      require('mini.comment').setup()

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'help', 'lazy' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require('mini.indentscope').setup({
        symbol = '│',
        options = { try_as_border = true },
      })

      require('mini.trailspace').setup()

      require('mini.tabline').setup()
      -- https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
      vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>%bd | e# | bd# <CR>', { silent = true, desc = 'Close other buffers' })
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
