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
        window_picker = {
          enable = false,
        },
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
      vim.keymap.del('n', 'B', { buffer = bufnr })
      vim.keymap.set('n', 'A', function()
        if vim.w.nvim_tree_width == nil then
          vim.w.nvim_tree_width = vim.api.nvim_win_get_width(0)
          vim.cmd(':wincmd |')
        else
          vim.api.nvim_win_set_width(0, vim.w.nvim_tree_width)
          vim.w.nvim_tree_width = nil
        end
      end, opts('Toggle Nvim-Tree Window Maximize/Minimize'))
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
