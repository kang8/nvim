return {
  'chrishrb/gx.nvim',
  keys = {
    { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } },
  },
  cmd = { 'Browse' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    handlers = {
      jira = {
        -- ABC-123 ABC-56
        -- vim.g.gx_jira_url = https://jira.example.com/browse/
        handle = function(mode, line, _)
          local id = require('gx.helper').find(line, mode, '(%u+-%d+)')
          local gx_jira_url = vim.g.gx_jira_url or os.getenv('WORK_JIRA_URL')
          if id then
            return gx_jira_url .. '/browse/' .. id
          end
        end,
      },
      gh_issue = {
        handle = function(mode, line, _)
          -- I'm assuming the system has the gh cli installed
          if not vim.fn.executable('gh') then
            return
          end
          local id = require('gx.helper').find(line, mode, '#(%d+)')
          if id then
            local cmd = string.format('gh issue view %s --json url --jq .url', id)
            local lines
            local job = vim.fn.jobstart(cmd, {
              stdout_buffered = true,
              on_stdout = function(_, __lines)
                lines = __lines
              end,
            })
            vim.fn.jobwait({ job })
            return lines[1]
          end
        end,
      },
    },
  },
}
