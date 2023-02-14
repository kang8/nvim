return {
  'kyazdani42/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  commit = '02fdc262eba188198a7deb2117b3b996e6763d65',
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'File Explorer' },
  },
  init = function()
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
    view = {
      mappings = {
        list = {
          { key = 'x', action = 'close_node' },
        },
      },
    },
    ui = {
      confirm = {
        remove = false,
      },
    },
    git = {
      ignore = false,
    },
  },
}
