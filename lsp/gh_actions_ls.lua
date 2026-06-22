-- GitHub Actions language server (gh-actions-language-server)
-- Only attaches inside workflow directories to avoid clashing with yamlls
-- on every yaml file.
local workflow_dirs = {
  '/.github/workflows',
  '/.gitea/workflows',
  '/.forgejo/workflows',
}

return {
  cmd = { 'gh-actions-language-server', '--stdio' },
  filetypes = { 'yaml' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local dir = vim.fs.dirname(fname)
    for _, suffix in ipairs(workflow_dirs) do
      if vim.endswith(dir, suffix) then
        on_dir(dir)
        return
      end
    end
  end,
  -- Needs to be present even if empty, see
  -- https://github.com/actions/languageservices/pull/119
  init_options = {},
  capabilities = {
    workspace = {
      didChangeWorkspaceFolders = {
        dynamicRegistration = true,
      },
    },
  },
  handlers = {
    -- The server asks the client to read referenced local action files.
    ['actions/readFile'] = function(_, params)
      local path = params and params.path
      if type(path) ~= 'string' or vim.fn.filereadable(path) == 0 then
        return ''
      end
      return table.concat(vim.fn.readfile(path), '\n')
    end,
  },
}
