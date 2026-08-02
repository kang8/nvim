local image_file_patterns = {
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
}

local image_read_events = vim.tbl_map(function(pattern)
  return 'BufReadPre ' .. pattern
end, image_file_patterns)

return {
  {
    '3rd/image.nvim',
    -- Use the ImageMagick CLI (`magick`) instead of the magick luarock, so
    -- there is nothing to compile.
    build = false,
    cond = function()
      return not vim.g.vscode
    end,
    event = image_read_events,
    ft = 'markdown',
    opts = {
      backend = 'kitty',
      processor = 'magick_cli',
      -- Register the image-file autocmd below so standalone previews can use
      -- a larger height than inline Markdown images.
      hijack_file_patterns = {},
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
    config = function(_, opts)
      local image = require('image')
      image.setup(opts)

      local function center_preview(preview, attempt)
        if
          not preview.window
          or not vim.api.nvim_win_is_valid(preview.window)
          or not preview.buffer
          or not vim.api.nvim_buf_is_valid(preview.buffer)
        then
          return
        end

        preview:render()
        local width = preview.rendered_geometry.width
        if preview.pending_transform_key or not width then
          if (attempt or 0) < 100 then
            vim.defer_fn(function()
              center_preview(preview, (attempt or 0) + 1)
            end, 20)
          end
          return
        end

        local x = math.max(0, math.floor((vim.api.nvim_win_get_width(preview.window) - width) / 2))
        if preview.geometry.x ~= x then
          local was_modifiable = vim.bo[preview.buffer].modifiable
          vim.bo[preview.buffer].modifiable = true
          vim.api.nvim_buf_set_lines(preview.buffer, 0, -1, false, { string.rep(' ', x + 1) })
          vim.bo[preview.buffer].modifiable = was_modifiable
          vim.bo[preview.buffer].modified = false
          preview:move(x, preview.geometry.y or 0)
        end
      end

      local function schedule_center(preview)
        if vim.v.vim_did_enter == 1 then
          vim.schedule(function()
            center_preview(preview)
          end)
        else
          vim.api.nvim_create_autocmd('VimEnter', {
            once = true,
            callback = function()
              vim.schedule(function()
                center_preview(preview)
              end)
            end,
          })
        end
      end

      vim.api.nvim_create_autocmd({ 'WinNew', 'BufWinEnter', 'TabEnter' }, {
        group = vim.api.nvim_create_augroup('image_file_preview', { clear = true }),
        pattern = image_file_patterns,
        callback = function(event)
          local preview =
            image.hijack_buffer(vim.api.nvim_buf_get_name(event.buf), vim.api.nvim_get_current_win(), event.buf, {
              max_height_window_percentage = 100,
            })
          if preview then
            schedule_center(preview)
          end
        end,
      })

      vim.api.nvim_create_autocmd('WinResized', {
        group = 'image_file_preview',
        callback = function()
          vim.schedule(function()
            for _, preview in ipairs(image.get_images()) do
              if
                preview.buffer
                and vim.api.nvim_buf_is_valid(preview.buffer)
                and vim.bo[preview.buffer].filetype == 'image_nvim'
              then
                center_preview(preview)
              end
            end
          end)
        end,
      })
    end,
  },
}
