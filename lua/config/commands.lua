vim.api.nvim_create_user_command('SpaceTo', function(opts)
  local char = opts.args
  vim.cmd(string.format('s/\\%%V /%s/g', char))
end, { range = true, nargs = 1 })

-- Copy selected lines in @File#L1-99 format and send to Claude window in Kitty
vim.api.nvim_create_user_command('CCLine', function(opts)
  local file_path = vim.fn.expand('%:p')
  local relative_path = vim.fn.fnamemodify(file_path, ':.')

  local format
  -- Check if called with a range (visual mode)
  if opts.range > 0 then
    local start_line = opts.line1
    local end_line = opts.line2

    if start_line == end_line then
      format = string.format('@%s#L%d', relative_path, start_line)
    else
      format = string.format('@%s#L%d-%d', relative_path, start_line, end_line)
    end
  else
    format = string.format('@%s', relative_path)
  end

  local function send_to_claude(win)
    local cmd = string.format("kitty @ send-text --match id:%d '%s '", win.id, format)
    vim.fn.system(cmd)
    vim.fn.system(string.format('kitty @ focus-window --match id:%d', win.id))
    vim.notify('Sent to Claude: ' .. format)
  end

  require('config.kitty_claude_picker').pick(function(win)
    if win then
      send_to_claude(win)
    else
      -- Fallback: copy to clipboard when no Claude window is found in tab
      vim.fn.setreg('+', format)
      vim.notify('Copied (no Claude window in tab): ' .. format, vim.log.levels.WARN)
    end
  end)
end, { range = true })
