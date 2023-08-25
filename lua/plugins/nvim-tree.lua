return {
  'nvim-tree/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Open file tree' },
  },
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      nested = true,
      callback = function()
        if #vim.api.nvim_list_wins() == 1 and require('nvim-tree.utils').is_nvim_tree_buf() then
          vim.cmd('quit')
        end
      end,
    })

    vim.api.nvim_create_autocmd({ 'QuitPre' }, {
      callback = function()
        vim.cmd('NvimTreeClose')
      end,
    })

    if vim.fn.argc() ~= 1 then
      return
    end

    local stat = vim.loop.fs_stat(vim.fn.argv(0))
    if not stat or stat.type == 'file' then
      return
    end

    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then
          return
        end

        vim.cmd.cd(data.file)

        require('nvim-tree.api').tree.open({
          current_window = true,
        })
      end,
    })
  end,
  opts = {
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    renderer = {
      icons = {
        show = {
          folder_arrow = false,
        },
      },
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr)

      vim.keymap.set('n', 'x', api.node.navigate.parent_close, opts('Close Directory'))
      vim.keymap.set('n', '<C-l>', '<cmd>NvimTreeResize +20<cr>', opts('Increase File Tree'))
      vim.keymap.set('n', '<C-h>', '<cmd>NvimTreeResize -20<cr>', opts('Decrease File Tree'))
      -- PERF: <leader>ta, Resize nvim-tree window maximize, how to store status
    end,
    ui = {
      confirm = {
        remove = false,
      },
    },
    git = {
      ignore = false,
    },
    live_filter = {
      always_show_folders = false,
    },
  },
}
