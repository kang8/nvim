return {
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    cond = function()
      return not vim.g.vscode
    end,
    ft = 'markdown',
    opts = {
      heading = {
        -- Width of the heading background:
        --  block: width of the heading text
        --  full:  full width of the window
        -- Can also be a list of the above values in which case the 'level' is used
        -- to index into the list using a clamp
        width = 'block',
      },
      sign = {
        enabled = false,
      },
    },
  },
  {
    '3rd/image.nvim',
    -- Use the ImageMagick CLI (`magick`) instead of the magick luarock, so
    -- there is nothing to compile.
    build = false,
    cond = function()
      return not vim.g.vscode
    end,
    ft = 'markdown',
    opts = {
      backend = 'kitty',
      processor = 'magick_cli',
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          only_render_image_at_cursor = false,
          filetypes = { 'markdown' },
          -- tree-sitter-markdown_inline keeps the angle brackets in the
          -- link_destination node for the CommonMark `[](<path>)` form, so
          -- image.nvim would look for a file literally named `<...png>`.
          resolve_image_path = function(document_path, image_path, fallback)
            return fallback(document_path, (image_path:gsub('^<(.*)>$', '%1')))
          end,
        },
      },
      max_height_window_percentage = 50,
    },
  },
}
