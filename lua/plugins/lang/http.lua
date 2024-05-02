return {
  {
    'nvim-treesitter/nvim-treesitter',
    ft = 'http',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'json', 'http' })
      end
    end,
  },
  {
    'rest-nvim/rest.nvim',
    commit = '1ce984c694345f3801bc656072f9a8dd51286a04', -- v1.2.1
    ft = 'http',
    config = function()
      vim.keymap.set('n', '<leader>rh', '<Plug>RestNvim', { desc = 'http-rest: [R]equest [H]TTP' })
      vim.keymap.set('n', '<leader>rp', '<Plug>RestNvimPreview', { desc = 'http-rest: [R]equest HTTP [P]review' })
      vim.keymap.set('n', '<leader>rl', '<Plug>RestNvimLast', { desc = 'http-rest: [R]equest [L]ast HTTP' })

      require('rest-nvim').setup({
        -- Open request results in a horizontal split
        result_split_horizontal = false,
        -- Keep the http file buffer above|left when split horizontal|vertical
        result_split_in_place = true,
        -- Skip SSL verification, useful for unknown certificates
        skip_ssl_verification = false,
        -- Encode URL before making request
        encode_url = true,
        -- Highlight request on run
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          -- toggle showing URL, HTTP info, headers at top the of result window
          show_url = true,
          show_http_info = true,
          show_headers = true,
          -- executables or functions for formatting response body [optional]
          -- set them to false if you want to disable them
          formatters = {
            json = 'jq',
            html = function(body)
              return vim.fn.system({ 'tidy', '-i', '-q', '-' }, body)
            end,
          },
        },
        -- Jump to request line on run
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end,
  },
}
