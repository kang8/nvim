-- Visual picker for selecting one agent CLI window in the current Kitty tab.
--
-- Public API:
--   M.pick(callback)                    -- defaults to Claude Code
--   M.pick({ target = 'codex' }, callback)
--   M.pick({ target = 'agent' }, callback) -- Claude or Codex
--
--   callback({ id, cwd, title }) on selection,
--   callback(nil)                when no matching window is reachable / cancelled.
--
-- When 0 windows match -> callback(nil) (caller usually does a clipboard fallback).
-- When 1 window matches → callback fires immediately, no UI.
-- When >=2 match -> opens a floating ASCII grid that approximates the tab
--                  layout and binds h/j/k/l plus Enter for the last selected
--                  window when it is still available.
--
-- The layout is reconstructed from `kitty @ ls`'s neighbor graph (which
-- references group ids, resolved through tab.groups). It's a topological
-- approximation, not pixel-accurate.

local M = {}

local STATE_FILE = vim.fn.stdpath('state') .. '/kitty_agent_picker_last.json'

local TARGETS = {
  claude = {
    display_name = 'Claude',
    patterns = { 'claude' },
  },
  codex = {
    display_name = 'Codex',
    patterns = { 'codex' },
  },
  agent = {
    display_name = 'Agent',
    patterns = { 'claude', 'codex' },
  },
}

local function normalize_target(target)
  target = target or 'claude'
  return TARGETS[target] and target or 'claude'
end

local function has_target(s, target)
  if type(s) ~= 'string' then
    return false
  end
  s = s:lower()
  for _, pattern in ipairs(TARGETS[target].patterns) do
    if s:find(pattern, 1, true) ~= nil then
      return true
    end
  end
  return false
end

local function detect_agent_name(s)
  if type(s) ~= 'string' then
    return nil
  end
  s = s:lower()
  if s:find('claude', 1, true) ~= nil then
    return 'Claude'
  end
  if s:find('codex', 1, true) ~= nil then
    return 'Codex'
  end
  return nil
end

local function window_matches_target(window, target)
  local agent_name = detect_agent_name(window.last_reported_cmdline) or detect_agent_name(window.title)
  if agent_name and has_target(agent_name, target) then
    return true, agent_name
  end
  for _, proc in ipairs(window.foreground_processes or {}) do
    for _, arg in ipairs(proc.cmdline or {}) do
      agent_name = detect_agent_name(arg)
      if agent_name and has_target(agent_name, target) then
        return true, agent_name
      end
    end
  end
  return false, nil
end

local function read_last_state()
  local f = io.open(STATE_FILE, 'r')
  if not f then
    return {}
  end
  local content = f:read('*a')
  f:close()
  if content == '' then
    return {}
  end
  local ok, data = pcall(vim.fn.json_decode, content)
  if not ok or type(data) ~= 'table' then
    return {}
  end
  return data
end

local function write_last_state(state)
  local dir = vim.fn.fnamemodify(STATE_FILE, ':h')
  vim.fn.mkdir(dir, 'p')
  local encoded = vim.fn.json_encode(state)
  local f = io.open(STATE_FILE, 'w')
  if not f then
    return
  end
  f:write(encoded)
  f:close()
end

local function remember_last_window(target, meta)
  if not meta or not meta.window_id then
    return
  end
  local state = read_last_state()
  state[target] = {
    window_id = meta.window_id,
    cwd = meta.cwd,
    title = meta.title,
    agent_name = meta.agent_name,
    updated_at = os.time(),
  }
  write_last_state(state)
end

local function find_last_group_id(target, target_group_ids, group_meta)
  local last = read_last_state()[target]
  if type(last) ~= 'table' or not last.window_id then
    return nil
  end
  for _, gid in ipairs(target_group_ids) do
    local meta = group_meta[gid]
    if meta and meta.window_id == last.window_id then
      return gid
    end
  end
  return nil
end

-- Collect everything we need from `kitty @ ls` for the current tab.
-- Returns nil if kitty isn't reachable / current tab can't be located.
-- Otherwise: {
--   self_window_id, self_group_id,
--   groups          = { [group_id] = { window_ids... } },
--   group_neighbors = { [group_id] = { left=[gids], right=[gids], top=[gids], bottom=[gids] } },
--   group_meta      = { [group_id] = { is_target, agent_name, cwd, title, window_id, lines, columns } },
--   history_rank    = { [window_id] = rank }  -- 1 = most recent
-- }
local function collect_tab_topology(target)
  local output = vim.fn.system('kitty @ ls')
  if vim.v.shell_error ~= 0 then
    return nil
  end
  local ok, data = pcall(vim.fn.json_decode, output)
  if not ok or not data then
    return nil
  end

  for _, os_window in ipairs(data) do
    for _, tab in ipairs(os_window.tabs or {}) do
      local self_window_id = nil
      for _, w in ipairs(tab.windows or {}) do
        if w.is_self then
          self_window_id = w.id
          break
        end
      end
      if self_window_id then
        local groups = {}
        for _, g in ipairs(tab.groups or {}) do
          groups[g.id] = g.windows or {}
        end

        local window_to_group = {}
        for gid, wids in pairs(groups) do
          for _, wid in ipairs(wids) do
            window_to_group[wid] = gid
          end
        end

        local group_neighbors = {}
        local group_meta = {}
        for _, w in ipairs(tab.windows or {}) do
          local gid = window_to_group[w.id]
          if gid then
            -- Merge neighbors from every window in the group (usually one).
            local merged = group_neighbors[gid] or { left = {}, right = {}, top = {}, bottom = {} }
            for dir, gids in pairs(w.neighbors or {}) do
              merged[dir] = merged[dir] or {}
              for _, ngid in ipairs(gids) do
                table.insert(merged[dir], ngid)
              end
            end
            group_neighbors[gid] = merged

            -- Mark group as target if any window in it matches; pick the
            -- matching window's metadata for display.
            local meta = group_meta[gid] or { is_target = false }
            local matches_target, agent_name = window_matches_target(w, target)
            if matches_target then
              meta.is_target = true
              meta.agent_name = agent_name
              meta.window_id = w.id
              meta.cwd = w.cwd
              meta.title = w.title
            elseif not meta.window_id then
              meta.window_id = w.id
              meta.cwd = w.cwd
              meta.title = w.title
            end
            meta.lines = w.lines
            meta.columns = w.columns
            group_meta[gid] = meta
          end
        end

        local history = tab.active_window_history or {}
        local rank = {}
        for i = #history, 1, -1 do
          rank[history[i]] = #history - i + 1
        end

        return {
          self_window_id = self_window_id,
          self_group_id = window_to_group[self_window_id],
          groups = groups,
          group_neighbors = group_neighbors,
          group_meta = group_meta,
          history_rank = rank,
        }
      end
    end
  end
  return nil
end

-- BFS from self_group_id over the neighbor graph.
-- Returns positions[gid] = { col, row, dir }
--   col, row: integer grid coords (self at 0,0)
--   dir: first cardinal step from self ('left'|'right'|'top'|'bottom') or nil for self
local DIRECTIONS = { 'right', 'bottom', 'left', 'top' }
local DELTA = {
  left = { -1, 0 },
  right = { 1, 0 },
  top = { 0, -1 },
  bottom = { 0, 1 },
}

-- Perpendicular offset per neighbor index for each direction.
-- Kitty's neighbor lists are ordered along the perpendicular axis:
--   left/right neighbors → ordered top to bottom (offset goes into +row)
--   top/bottom neighbors → ordered left to right (offset goes into +col)
local PERP = {
  left = { 0, 1 },
  right = { 0, 1 },
  top = { 1, 0 },
  bottom = { 1, 0 },
}

local function compute_layout(self_group_id, group_neighbors)
  local positions = { [self_group_id] = { col = 0, row = 0, dir = nil } }
  local occupied = { [self_group_id] = true }
  local function key(c, r)
    return c .. ',' .. r
  end
  local cell_owner = { [key(0, 0)] = self_group_id }
  local queue = { self_group_id }
  local head = 1
  while head <= #queue do
    local gid = queue[head]
    head = head + 1
    local pos = positions[gid]
    local neighbors = group_neighbors[gid] or {}
    for _, dir in ipairs(DIRECTIONS) do
      local list = neighbors[dir] or {}
      local dx, dy = DELTA[dir][1], DELTA[dir][2]
      local px, py = PERP[dir][1], PERP[dir][2]
      for i, ngid in ipairs(list) do
        if not occupied[ngid] then
          local nc = pos.col + dx + (i - 1) * px
          local nr = pos.row + dy + (i - 1) * py
          -- If the natural slot is taken, slide further along the perpendicular axis.
          while cell_owner[key(nc, nr)] do
            nc = nc + px
            nr = nr + py
          end
          positions[ngid] = {
            col = nc,
            row = nr,
            dir = pos.dir or dir,
          }
          occupied[ngid] = true
          cell_owner[key(nc, nr)] = ngid
          table.insert(queue, ngid)
        end
      end
    end
  end
  return positions
end

-- Compute the spanning rectangle for each group based on its neighbors'
-- positions: a group spans every row that any of its left/right neighbors
-- occupies (since they all sit beside it), and every col that its top/bottom
-- neighbors occupy. Spans only extend into empty grid cells to avoid overlap.
local function compute_spans(positions, group_neighbors)
  local cell_owner = {}
  for gid, pos in pairs(positions) do
    cell_owner[pos.col .. ',' .. pos.row] = gid
  end
  local spans = {}
  for gid, pos in pairs(positions) do
    local row_lo, row_hi = pos.row, pos.row
    local col_lo, col_hi = pos.col, pos.col
    local neighbors = group_neighbors[gid] or {}
    for _, dir in ipairs({ 'left', 'right' }) do
      for _, ngid in ipairs(neighbors[dir] or {}) do
        local np = positions[ngid]
        if np then
          if np.row < row_lo then
            row_lo = np.row
          end
          if np.row > row_hi then
            row_hi = np.row
          end
        end
      end
    end
    for _, dir in ipairs({ 'top', 'bottom' }) do
      for _, ngid in ipairs(neighbors[dir] or {}) do
        local np = positions[ngid]
        if np then
          if np.col < col_lo then
            col_lo = np.col
          end
          if np.col > col_hi then
            col_hi = np.col
          end
        end
      end
    end
    -- Shrink span if it would overlap another group's anchor cell.
    while row_lo < pos.row do
      local blocked = false
      for c = col_lo, col_hi do
        local owner = cell_owner[c .. ',' .. row_lo]
        if owner and owner ~= gid then
          blocked = true
          break
        end
      end
      if blocked then
        row_lo = row_lo + 1
      else
        break
      end
    end
    while row_hi > pos.row do
      local blocked = false
      for c = col_lo, col_hi do
        local owner = cell_owner[c .. ',' .. row_hi]
        if owner and owner ~= gid then
          blocked = true
          break
        end
      end
      if blocked then
        row_hi = row_hi - 1
      else
        break
      end
    end
    while col_lo < pos.col do
      local blocked = false
      for r = row_lo, row_hi do
        local owner = cell_owner[col_lo .. ',' .. r]
        if owner and owner ~= gid then
          blocked = true
          break
        end
      end
      if blocked then
        col_lo = col_lo + 1
      else
        break
      end
    end
    while col_hi > pos.col do
      local blocked = false
      for r = row_lo, row_hi do
        local owner = cell_owner[col_hi .. ',' .. r]
        if owner and owner ~= gid then
          blocked = true
          break
        end
      end
      if blocked then
        col_hi = col_hi - 1
      else
        break
      end
    end
    spans[gid] = { col_lo = col_lo, col_hi = col_hi, row_lo = row_lo, row_hi = row_hi }
  end
  return spans
end

-- Assign h/j/k/l (lower then upper) to target groups, ordered by recency.
-- Returns: keymap = { [key] = group_id }, group_keys = { [group_id] = key }
local DIR_TO_KEY = { left = 'h', bottom = 'j', top = 'k', right = 'l' }

local function assign_direction_keys(target_group_ids, positions, group_meta, history_rank)
  -- Bucket by first-step direction.
  local buckets = { left = {}, right = {}, top = {}, bottom = {} }
  for _, gid in ipairs(target_group_ids) do
    local pos = positions[gid]
    if pos and pos.dir then
      table.insert(buckets[pos.dir], gid)
    end
  end
  -- Sort each bucket by recency (lower rank = more recent).
  for _, bucket in pairs(buckets) do
    table.sort(bucket, function(a, b)
      local wa = group_meta[a].window_id
      local wb = group_meta[b].window_id
      return (history_rank[wa] or math.huge) < (history_rank[wb] or math.huge)
    end)
  end
  local keymap = {}
  local group_keys = {}
  for dir, bucket in pairs(buckets) do
    local lower = DIR_TO_KEY[dir]
    local upper = lower:upper()
    if bucket[1] then
      keymap[lower] = bucket[1]
      group_keys[bucket[1]] = lower
    end
    if bucket[2] then
      keymap[upper] = bucket[2]
      group_keys[bucket[2]] = upper
    end
    -- 3rd+ in same direction: no key (rare).
  end
  return keymap, group_keys
end

-- Render the layout grid into a list of strings.
-- Cells share borders with neighbors: a cell occupies a CELL_W × CELL_H region
-- where the perimeter is the (shared) border and the interior is
-- (CELL_W - 1) × (CELL_H - 1) for content.
local CELL_W = 15
local CELL_H = 4

local function center_text(s, width)
  s = s or ''
  local dw = vim.fn.strdisplaywidth(s)
  if dw >= width then
    -- Truncate by display width.
    while dw > width and #s > 0 do
      s = vim.fn.strcharpart(s, 0, vim.fn.strchars(s) - 1)
      dw = vim.fn.strdisplaywidth(s)
    end
    return s .. string.rep(' ', width - dw)
  end
  local left = math.floor((width - dw) / 2)
  local right = width - dw - left
  return string.rep(' ', left) .. s .. string.rep(' ', right)
end

local function render_layout_grid(spans, self_group_id, group_meta, group_keys, default_group_id)
  -- Find bounds across all spans (not just anchor positions).
  local min_c, max_c, min_r, max_r = 0, 0, 0, 0
  for _, span in pairs(spans) do
    if span.col_lo < min_c then
      min_c = span.col_lo
    end
    if span.col_hi > max_c then
      max_c = span.col_hi
    end
    if span.row_lo < min_r then
      min_r = span.row_lo
    end
    if span.row_hi > max_r then
      max_r = span.row_hi
    end
  end
  local cols = max_c - min_c + 1
  local rows = max_r - min_r + 1

  -- Per-cell ownership for border drawing — every cell inside a span is owned.
  local owned_cells = {} -- list of { gid, c_lo, c_hi, r_lo, r_hi }
  for gid, span in pairs(spans) do
    table.insert(owned_cells, {
      gid = gid,
      c_lo = span.col_lo - min_c + 1,
      c_hi = span.col_hi - min_c + 1,
      r_lo = span.row_lo - min_r + 1,
      r_hi = span.row_hi - min_r + 1,
    })
  end

  -- Adjacent cells share borders: total = cells * (CELL_W - 1) + 1 character of trailing border.
  local total_w = cols * (CELL_W - 1) + 1
  local total_h = rows * (CELL_H - 1) + 1

  -- Build a 2D char buffer (rows of arrays of unicode chars/strings).
  local buf = {}
  for y = 1, total_h do
    buf[y] = {}
    for x = 1, total_w do
      buf[y][x] = ' '
    end
  end

  local function cell_origin(c, r)
    return (c - 1) * (CELL_W - 1) + 1, (r - 1) * (CELL_H - 1) + 1
  end

  -- Mark which border segments exist (so junctions can be computed).
  -- horiz[y][x] = true means a horizontal segment between (x,y)-(x+1,y).
  -- vert[y][x] = true means a vertical segment between (x,y)-(x,y+1).
  local horiz = {}
  local vert = {}
  for y = 1, total_h do
    horiz[y] = {}
    vert[y] = {}
  end

  for _, cell in ipairs(owned_cells) do
    local x0, y0 = cell_origin(cell.c_lo, cell.r_lo)
    -- Right border of a span sits at the next column's origin x; same for bottom.
    local x1 = (cell.c_hi - 1 + 1) * (CELL_W - 1) + 1
    local y1 = (cell.r_hi - 1 + 1) * (CELL_H - 1) + 1
    for x = x0, x1 - 1 do
      horiz[y0][x] = true
      horiz[y1][x] = true
    end
    for y = y0, y1 - 1 do
      vert[y][x0] = true
      vert[y][x1] = true
    end
  end

  -- Resolve junction characters for each (x, y) point.
  for y = 1, total_h do
    for x = 1, total_w do
      local up = (y > 1 and vert[y - 1] and vert[y - 1][x]) and true or false
      local down = (vert[y] and vert[y][x]) and true or false
      local left = (x > 1 and horiz[y] and horiz[y][x - 1]) and true or false
      local right = (horiz[y] and horiz[y][x]) and true or false
      local ch = nil
      local count = (up and 1 or 0) + (down and 1 or 0) + (left and 1 or 0) + (right and 1 or 0)
      if count == 4 then
        ch = '┼'
      elseif count == 3 then
        if not up then
          ch = '┬'
        elseif not down then
          ch = '┴'
        elseif not left then
          ch = '├'
        else
          ch = '┤'
        end
      elseif count == 2 then
        if up and down then
          ch = '│'
        elseif left and right then
          ch = '─'
        elseif down and right then
          ch = '┌'
        elseif down and left then
          ch = '┐'
        elseif up and right then
          ch = '└'
        else
          ch = '┘'
        end
      elseif count == 1 then
        if left or right then
          ch = '─'
        else
          ch = '│'
        end
      end
      if ch then
        buf[y][x] = ch
      end
    end
  end

  -- Fill cell content centered within the full span.
  for _, cell in ipairs(owned_cells) do
    local gid = cell.gid
    local meta = group_meta[gid] or {}
    local label, name
    if gid == self_group_id then
      label = '[*]'
      name = 'nvim'
    elseif gid == default_group_id and group_keys[gid] then
      label = '[' .. group_keys[gid] .. '/Enter]'
      name = vim.fn.fnamemodify(meta.cwd or '', ':t')
    elseif gid == default_group_id then
      label = '[Enter]'
      name = vim.fn.fnamemodify(meta.cwd or '', ':t')
    elseif group_keys[gid] then
      label = '[' .. group_keys[gid] .. ']'
      name = vim.fn.fnamemodify(meta.cwd or '', ':t')
    else
      label = ' '
      name = vim.fn.fnamemodify(meta.cwd or '', ':t')
    end

    local x0, y0 = cell_origin(cell.c_lo, cell.r_lo)
    local x1 = cell.c_hi * (CELL_W - 1) + 1
    local y1 = cell.r_hi * (CELL_H - 1) + 1
    local interior_w = x1 - x0 - 1
    local interior_h = y1 - y0 - 1
    local content = { center_text(label, interior_w), center_text(name, interior_w) }
    -- Vertically center two lines of content in interior_h.
    local top_pad = math.max(0, math.floor((interior_h - #content) / 2))
    for i, line in ipairs(content) do
      local y = y0 + top_pad + i
      if y < y1 then
        local chars = vim.fn.split(line, '\\zs')
        for j = 1, math.min(#chars, interior_w) do
          buf[y][x0 + j] = chars[j]
        end
      end
    end
  end

  -- Trim each row to its real content (avoid trailing spaces beyond drawn cells).
  local lines = {}
  for y = 1, total_h do
    local row = table.concat(buf[y])
    -- Right-trim.
    row = row:gsub('%s+$', '')
    table.insert(lines, row)
  end
  -- Drop trailing empty lines.
  while #lines > 0 and lines[#lines] == '' do
    table.remove(lines)
  end
  return lines
end

local function open_picker_floating(lines, on_key)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false
  vim.bo[buf].bufhidden = 'wipe'

  local width = 0
  for _, l in ipairs(lines) do
    local w = vim.fn.strdisplaywidth(l)
    if w > width then
      width = w
    end
  end
  local height = #lines
  local ui = vim.api.nvim_list_uis()[1] or { width = vim.o.columns, height = vim.o.lines }
  local row = math.max(0, math.floor((ui.height - height) / 2))
  local col = math.max(0, math.floor((ui.width - width) / 2))

  local win = vim.api.nvim_open_win(buf, false, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = 'none',
    focusable = false,
    noautocmd = true,
  })

  vim.cmd('redraw')
  local ok, ch = pcall(vim.fn.getcharstr)
  if vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
  end
  if not ok then
    return
  end
  on_key(ch)
end

function M.pick(opts, callback)
  if type(opts) == 'function' then
    callback = opts
    opts = {}
  end
  opts = opts or {}
  local target = normalize_target(opts.target)
  local display_name = TARGETS[target].display_name

  local topo = collect_tab_topology(target)
  if not topo then
    callback(nil)
    return
  end

  local target_group_ids = {}
  for gid, meta in pairs(topo.group_meta) do
    if meta.is_target and gid ~= topo.self_group_id then
      table.insert(target_group_ids, gid)
    end
  end

  if #target_group_ids == 0 then
    callback(nil)
    return
  end

  if #target_group_ids == 1 then
    local meta = topo.group_meta[target_group_ids[1]]
    remember_last_window(target, meta)
    callback({ id = meta.window_id, cwd = meta.cwd, title = meta.title, agent_name = meta.agent_name or display_name })
    return
  end

  local positions = compute_layout(topo.self_group_id, topo.group_neighbors)
  local spans = compute_spans(positions, topo.group_neighbors)
  local keymap, group_keys = assign_direction_keys(target_group_ids, positions, topo.group_meta, topo.history_rank)
  local default_group_id = find_last_group_id(target, target_group_ids, topo.group_meta)
  local grid_lines = render_layout_grid(spans, topo.self_group_id, topo.group_meta, group_keys, default_group_id)

  local available = {}
  for _, k in ipairs({ 'h', 'j', 'k', 'l', 'H', 'J', 'K', 'L' }) do
    if keymap[k] then
      table.insert(available, k)
    end
  end
  table.insert(grid_lines, '')
  table.insert(
    grid_lines,
    'Pick '
      .. display_name
      .. ': '
      .. table.concat(available, '/')
      .. (default_group_id and '/Enter' or '')
      .. '  (Esc to cancel) - approximate layout'
  )

  open_picker_floating(grid_lines, function(ch)
    local gid = keymap[ch]
    if not gid and (ch == '\r' or ch == '\n') then
      gid = default_group_id
    end
    if not gid then
      return
    end
    local meta = topo.group_meta[gid]
    remember_last_window(target, meta)
    callback({ id = meta.window_id, cwd = meta.cwd, title = meta.title, agent_name = meta.agent_name or display_name })
  end)
end

return M
