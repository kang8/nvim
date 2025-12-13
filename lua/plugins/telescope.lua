return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'debugloop/telescope-undo.nvim',
    },
    keys = {
      { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch Buffer' },
      { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>/', '<cmd>Telescope live_grep<cr>', desc = 'Find in Files (Grep)' },
      { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'Find Files (root dir)' },
      -- search
      { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
      { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
      { '<leader>sc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
      { '<leader>sC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
      { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = 'Diagnostics' },
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
      { '<leader>sH', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
      { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
      { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
      { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'Jump to Mark' },
      { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
      { '<leader>sr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent' },
      { '<leader>su', '<cmd>Telescope undo<cr>', desc = 'Undo' },
      -- personal preference
      { '<C-S-f>', '<cmd>Telescope live_grep<cr>', desc = 'Find in Files (Grep)' },
    },
    opts = {
      defaults = {
        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            prompt_position = 'top',
          },
        },
      },
    },
    config = function(_, opts)
      local vimgrep_arguments = { unpack(require('telescope.config').values.vimgrep_arguments) }

      table.insert(vimgrep_arguments, '--hidden')

      require('telescope').setup(vim.tbl_deep_extend('force', {
        defaults = {
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            find_command = { 'fd', '--type', 'f', '--hidden', '--follow', '--exclude', '.git' },
          },
        },
      }, opts or {}))
      require('telescope').load_extension('undo')
    end,
  },
}
