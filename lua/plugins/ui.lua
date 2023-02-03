return {
  {
    'echasnovski/mini.tabline',
    event = 'BufReadPost',
    config = function()
      require('mini.tabline').setup()
      -- https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
      vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>%bd | e# | bd# <CR>', { silent = true, desc = 'Close other buffers' })
    end,
  },
  {
    'echasnovski/mini.indentscope',
    event = 'VeryLazy',
    config = function()
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
    end,
  },
  {
    'echasnovski/mini.trailspace',
    event = 'BufReadPost',
    config = function()
      require('mini.trailspace').setup()
    end,
  },
}
