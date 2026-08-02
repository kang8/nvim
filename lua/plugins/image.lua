return {
  {
    '3rd/image.nvim',
    -- Use the ImageMagick CLI (`magick`) instead of the magick luarock, so
    -- there is nothing to compile.
    build = false,
    cond = function()
      return not vim.g.vscode
    end,
    event = {
      'BufReadPre *.png',
      'BufReadPre *.PNG',
      'BufReadPre *.jpg',
      'BufReadPre *.JPG',
      'BufReadPre *.jpeg',
      'BufReadPre *.JPEG',
      'BufReadPre *.gif',
      'BufReadPre *.GIF',
      'BufReadPre *.webp',
      'BufReadPre *.WEBP',
      'BufReadPre *.avif',
      'BufReadPre *.AVIF',
    },
    ft = 'markdown',
    opts = {
      backend = 'kitty',
      processor = 'magick_cli',
      hijack_file_patterns = {
        '*.png',
        '*.PNG',
        '*.jpg',
        '*.JPG',
        '*.jpeg',
        '*.JPEG',
        '*.gif',
        '*.GIF',
        '*.webp',
        '*.WEBP',
        '*.avif',
        '*.AVIF',
      },
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
