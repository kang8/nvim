return {
  {
    'echasnovski/mini.tabline',
    event = 'BufReadPost',
    config = function()
      require('mini.tabline').setup({})
      vim.keymap.set('n', '<C-c>', function()
        for _, bufinfo in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
          if bufinfo.bufnr ~= vim.fn.bufnr() then
            vim.print(bufinfo.bufnr)
            vim.api.nvim_buf_delete(bufinfo.bufnr, { force = true })
          end
        end

        vim.cmd('redrawtabline') -- Delete other buffers does not automatically redraw tabline, so do this manually.
      end, { desc = 'Close other buffers' })
    end,
  },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'UIEnter' },
    opts = {
      chunk = {
        exclude_filetypes = {
          fugitiveblame = true,
          git = true,
          sql = true,
        },
      },
      line_num = {
        enable = false,
      },
      indent = {
        enable = false,
      },
      blank = {
        enable = false,
      },
    },
    config = function(_, opts)
      require('hlchunk').setup(opts)

      vim.api.nvim_del_user_command('EnableHL')
      vim.api.nvim_del_user_command('EnableHLChunk')
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
          {
            function()
              local style = vim.bo.expandtab and 'Spaces' or 'Tab Size'
              local size = vim.bo.expandtab and vim.bo.tabstop or vim.bo.shiftwidth
              return style .. ': ' .. size
            end,
            cond = function()
              return vim.bo.filetype ~= ''
            end,
          },
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
        'cmp_menu',
        'cmp_docs',
        'fugitiveblame',
        'dropbar_menu',
      },
    },
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = true,
  },
}
