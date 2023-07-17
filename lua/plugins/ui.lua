return {
  {
    'echasnovski/mini.tabline',
    event = 'BufReadPost',
    config = function()
      require('mini.tabline').setup({})
      vim.keymap.set('n', '<C-c>', function()
        local cur_buf = vim.api.nvim_get_current_buf()

        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if buf ~= cur_buf then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end

        vim.cmd('redrawtabline') -- Delete other buffers does not automatically redraw tabline, so do this manually.
      end, { desc = 'Close other buffers' })
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
      require('mini.trailspace').setup({})
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
      extensions = { 'nvim-tree' },
    },
  },
  { 'nvim-tree/nvim-web-devicons', lazy = true },
  {
    'Bekaboo/dropbar.nvim',
    lazy = false,
    -- stylua: ignore
    keys = {
      { '<leader>mp', function() require('dropbar.api').pick() end, mode = { 'n' }, desc = 'breadcrumb: [M]enu [P]ick', },
    },
    opts = {
      menu = {
        preview = false,
        keymaps = {
          ['q'] = function()
            local menu = require('dropbar.api').get_current_dropbar_menu()

            if not menu then
              return
            end

            local prev_menu = menu.prev_menu
            local root_menu = nil

            while prev_menu do
              root_menu = prev_menu
              prev_menu = prev_menu.prev_menu
            end

            if root_menu then
              root_menu:close()
            else
              menu:close()
            end
          end,
          ['h'] = '<C-w>c',
          ['l'] = function()
            local menu = require('dropbar.api').get_current_dropbar_menu()

            if not menu then
              return
            end

            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])

            if component then
              menu:click_on(component, nil, 1, 'l')
            end
          end,
        },
      },
      icons = {
        ui = {
          menu = {
            indicator = '',
          },
        },
      },
      bar = {
        pick = {
          pivots = 'asdfghjklzxcvbnm,./qwertyuiop',
        },
      },
    },
  },
  {
    'petertriho/nvim-scrollbar',
    opts = {
      handlers = {
        gitsigns = true,
      },
      handle = {
        color = '#9ca0b0',
      },
      excluded_filetypes = {
        'NvimTree',
      },
    },
  },
}
