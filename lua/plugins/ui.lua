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
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = { statusline = { 'lazy' } },
        section_separators = {},
        component_separators = { '', '|' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_c = {
          { 'filename', path = 1 },
        },
        lualine_x = {
          { 'filetype' },
        },
        lualine_y = {
          { 'progress', separator = '', padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return ' ' .. os.date('%R')
          end,
        },
      },
    },
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
}
