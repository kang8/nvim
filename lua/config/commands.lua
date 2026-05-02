vim.api.nvim_create_user_command('SpaceTo', function(opts)
  local char = opts.args
  vim.cmd(string.format('s/\\%%V /%s/g', char))
end, { range = true, nargs = 1 })

local function current_file_reference(opts)
  local file_path = vim.fn.expand('%:p')
  local relative_path = vim.fn.fnamemodify(file_path, ':.')

  -- Check if called with a range (visual mode)
  if opts.range > 0 then
    local start_line = opts.line1
    local end_line = opts.line2

    if start_line == end_line then
      return string.format('@%s#L%d', relative_path, start_line)
    else
      return string.format('@%s#L%d-%d', relative_path, start_line, end_line)
    end
  end

  return string.format('@%s', relative_path)
end

local function send_current_file_reference(opts, target, display_name)
  local format = current_file_reference(opts)

  local function send_to_agent(win)
    vim.fn.system({ 'kitty', '@', 'send-text', '--match', 'id:' .. win.id, format .. ' ' })
    vim.fn.system({ 'kitty', '@', 'focus-window', '--match', 'id:' .. win.id })
    vim.notify('Sent to ' .. display_name .. ': ' .. format)
  end

  require('config.kitty_claude_picker').pick({ target = target }, function(win)
    if win then
      display_name = win.agent_name or display_name
      send_to_agent(win)
    else
      -- Fallback: copy to clipboard when no matching window is found in tab
      vim.fn.setreg('+', format)
      vim.notify('Copied (no ' .. display_name .. ' window in tab): ' .. format, vim.log.levels.WARN)
    end
  end)
end

-- Copy selected lines in @File#L1-99 format and send to Claude window in Kitty
vim.api.nvim_create_user_command('CCLine', function(opts)
  send_current_file_reference(opts, 'claude', 'Claude')
end, { range = true })

-- Copy selected lines in @File#L1-99 format and send to Codex window in Kitty
vim.api.nvim_create_user_command('CodexLine', function(opts)
  send_current_file_reference(opts, 'codex', 'Codex')
end, { range = true })

-- Copy selected lines in @File#L1-99 format and send to Claude or Codex in Kitty
vim.api.nvim_create_user_command('AgentLine', function(opts)
  send_current_file_reference(opts, 'agent', 'Claude/Codex')
end, { range = true })
