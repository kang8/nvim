return {
  'reegnz/gx-extended.nvim',
  branch = 'dev',
  keys = {
    { 'gx', mode = { 'n', 'x' } },
  },
  opts = {
    open_fn = require('lazy.util').open,
    -- log_level = vim.log.levels.DEBUG,
    extensions = {
      {
        -- ABC-123 ABC-56
        -- vim.g.gx_jira_url = https://jira.example.com/browse/
        name = 'Open JIRA Issue',
        match_to_url = function(line_string)
          local gx_jira_url = vim.g.gx_jira_url or os.getenv('WORK_JIRA_URL')
          if not gx_jira_url then
            return nil
          end
          local col = vim.fn.col('.')
          local match_start
          --- @type integer|nil
          local match_end = 1
          local ticket
          while true do
            match_start, match_end, ticket = string.find(line_string, '(%a+-%d+)', match_end)
            if not ticket then
              return nil
            end
            if match_start <= col and match_end >= col then
              break
            end
          end
          return gx_jira_url .. ticket
        end,
      },
      {
        name = 'Google Search in Visual Mode',
        match_to_url = function()
          local mode = vim.api.nvim_get_mode().mode
          local is_visual = mode:match('[vV\x16]')
          -- only trigger searches for visual selection
          if not is_visual then
            return nil
          end
          local vstart = vim.fn.getpos('v')
          local vend = vim.fn.getpos('.')
          if vstart[2] > vend[2] then
            vstart, vend = vend, vstart
          end
          if vstart[2] == vend[2] and vstart[3] > vend[3] then
            vstart, vend = vend, vstart
          end
          local lines = vim.api.nvim_buf_get_lines(0, vstart[2] - 1, vend[2], true)
          if #lines == 0 then
            return nil
          end
          lines[#lines] = string.sub(lines[#lines], 1, vend[3])
          lines[1] = string.sub(lines[1], vstart[3])
          local query = table.concat(lines, ' ')
          return 'https://google.com/search?q=' .. query
        end,
      },
      {
        name = 'Open Markdown Link',
        filetypes = { 'markdown' },
        match_to_url = function(line_string)
          local cursor = vim.fn.getpos('.')
          local match = vim.fn.matchstrpos(line_string, '\\[.+\\]\\((.+)\\)', cursor[3])
          if cursor[3] < match[2] or cursor[3] > match[3] then
            -- cursor is not within pattern
            return
          end
          line_string:sub(match[2], match[3] + 1)
          local url = line_string:match('%[%]%(.+)%)')
          if url then
            return url
          end
          return nil
        end,
      },
      {
        name = 'Open GitHub issue',
        match_to_url = function(line_string)
          if not vim.fn.executable('gh') then
            return nil
          end
          local col = vim.fn.col('.')
          local match_start, match_end, issue = string.find(line_string, '#(%d+)')
          if not issue or match_start > col or match_end < col then
            return nil
          end
          local cmd = string.format('gh issue view %s --json url --jq .url', issue)
          local lines
          local job = vim.fn.jobstart(cmd, {
            stdout_buffered = true,
            on_stdout = function(_, __lines)
              lines = __lines
            end,
          })
          vim.fn.jobwait({ job })
          return lines[1]
        end,
      },
      {
        name = 'Open brew formula/cask',
        filenames = { 'Brewfile' },
        match_to_url = function(line_string)
          local _, _, brew = string.find(line_string, 'brew ["]([^%s]+)["]')
          if brew then
            return 'https://formulae.brew.sh/formula/' .. brew
          end
          local _, _, cask = string.find(line_string, 'cask ["]([^%s]+)["]')
          if cask then
            return 'https://formulae.brew.sh/cask/' .. cask
          end
          return nil
        end,
      },
      {
        name = 'Open lazy.nvim plugin',
        patterns = { '*/.config/nvim/**/*.lua', '*/.local/share/nvim/lazy/LazyVim/lua/lazyvim/**/*.lua' },
        filetypes = { 'lua' },
        match_to_url = function(line_string)
          local _, _, repo = string.find(line_string, "[\"'']([^%s~/]+/[^%s~/]+)[\"'']")
          if not repo then
            return nil
          end
          return 'https://github.com/' .. repo
        end,
      },
    },
  },
}
