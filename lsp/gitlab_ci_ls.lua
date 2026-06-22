-- GitLab CI language server (gitlab-ci-ls)
-- Attaches only to the `yaml.gitlab` filetype (set in filetype.lua) so it stays
-- scoped to GitLab CI files. yamlls also attaches to this filetype for schema
-- validation; the two are designed to coexist.
local cache_dir = vim.fn.stdpath('cache') .. '/gitlab-ci-ls'

-- gitlab-ci-ls can't resolve `component:` includes whose version is a branch ref
-- containing slashes (e.g. `release/toolchain/v0.1.0`, our component repo's
-- versioning convention). Because the component never resolves, every job that
-- `extends` a hidden job defined inside it gets a false "Rule: ... does not
-- exist." We drop only those diagnostics; real ones (stage/needs/...) survive.
local default_publish = vim.lsp.handlers['textDocument/publishDiagnostics']

return {
  cmd = { 'gitlab-ci-ls' },
  filetypes = { 'yaml.gitlab' },
  -- `.gitlab-ci-ls.yml` lets template-only repos declare their root CI files.
  root_markers = { '.gitlab-ci.yml', '.gitlab-ci-ls.yml', '.git' },
  init_options = {
    cache_path = cache_dir .. '/cache/',
    log_path = cache_dir .. '/log/gitlab-ci-ls.log',
  },
  handlers = {
    ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
      if result and result.diagnostics then
        result.diagnostics = vim.tbl_filter(function(d)
          return not tostring(d.message or ''):match('^Rule:.*does not exist')
        end, result.diagnostics)
      end
      return default_publish(err, result, ctx, config)
    end,
  },
}
