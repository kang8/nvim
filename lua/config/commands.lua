vim.api.nvim_create_user_command('SpaceTo', function(opts)
  local char = opts.args
  vim.cmd(string.format('s/\\%%V /%s/g', char))
end, { range = true, nargs = 1 })

-- Find Claude window ID in the same Kitty tab
local function find_claude_window_id()
  local output = vim.fn.system('kitty @ ls')
  if vim.v.shell_error ~= 0 then
    return nil
  end

  local ok, data = pcall(vim.fn.json_decode, output)
  if not ok or not data then
    return nil
  end

  -- Find current tab (contains is_self window)
  for _, os_window in ipairs(data) do
    for _, tab in ipairs(os_window.tabs or {}) do
      local current_tab = false
      local claude_window_id = nil

      for _, window in ipairs(tab.windows or {}) do
        if window.is_self then
          current_tab = true
        end
        local cmdline = window.last_reported_cmdline or ''
        if cmdline:find('claude') then
          claude_window_id = window.id
        end
      end

      if current_tab and claude_window_id then
        return claude_window_id
      end
    end
  end

  return nil
end

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

  -- Copy to clipboard (fallback)
  vim.fn.setreg('+', format)

  -- Find and send to Claude window in same tab
  local claude_id = find_claude_window_id()
  if claude_id then
    local cmd = string.format("kitty @ send-text --match id:%d '%s '", claude_id, format)
    vim.fn.system(cmd)
    vim.fn.system(string.format('kitty @ focus-window --match id:%d', claude_id))
    vim.notify('Sent to Claude: ' .. format)
  else
    vim.notify('Copied (no Claude window in tab): ' .. format, vim.log.levels.WARN)
  end
end, { range = true })
