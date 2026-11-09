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

local agent_names = { claude = 'Claude', codex = 'Codex' }

local function herdr(args)
  local output = vim.fn.system(vim.list_extend({ 'herdr' }, args))
  if vim.v.shell_error ~= 0 then
    return nil
  end
  local ok, data = pcall(vim.json.decode, output)
  return ok and data.result or nil
end

-- Inside herdr kitty only sees the herdr window, but herdr reports which agent
-- each pane runs. Picks from the agents in the same herdr tab as this nvim.
local function pick_herdr_agent(target, display_name, callback)
  local current = herdr({ 'pane', 'current' })
  local list = herdr({ 'agent', 'list' })
  if not current or not list then
    return callback(nil)
  end

  local agents = {}
  for _, a in ipairs(list.agents) do
    if a.tab_id == current.pane.tab_id and agent_names[a.agent] and (target == 'agent' or a.agent == target) then
      table.insert(
        agents,
        { pane_id = a.pane_id, agent_name = agent_names[a.agent], title = a.terminal_title_stripped }
      )
    end
  end

  if #agents <= 1 then
    return callback(agents[1])
  end
  vim.ui.select(agents, {
    prompt = 'Pick ' .. display_name,
    format_item = function(a)
      return a.agent_name .. '  ' .. a.title
    end,
  }, callback)
end

local function send_current_file_reference(opts, target, display_name)
  local format = current_file_reference(opts)

  local function deliver(win, send)
    if not win then
      -- Fallback: copy to clipboard when no matching window is found in tab
      vim.fn.setreg('+', format)
      vim.notify('Copied (no ' .. display_name .. ' window in tab): ' .. format, vim.log.levels.WARN)
      return
    end
    send(win)
    vim.notify('Sent to ' .. (win.agent_name or display_name) .. ': ' .. format)
  end

  if vim.env.HERDR_PANE_ID then
    pick_herdr_agent(target, display_name, function(agent)
      deliver(agent, function(a)
        vim.fn.system({ 'herdr', 'pane', 'send-text', a.pane_id, format .. ' ' })
        vim.fn.system({ 'herdr', 'agent', 'focus', a.pane_id })
      end)
    end)
    return
  end

  require('kitty-agent-picker').pick({ target = target }, function(win)
    deliver(win, function(w)
      vim.fn.system({ 'kitty', '@', 'send-text', '--match', 'id:' .. w.id, format .. ' ' })
      vim.fn.system({ 'kitty', '@', 'focus-window', '--match', 'id:' .. w.id })
    end)
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
