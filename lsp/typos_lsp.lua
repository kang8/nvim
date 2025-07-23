return {
  name = 'typos-lsp',
  cmd = { 'typos-lsp' },
  filetypes = { '*' },
  root_markers = { 'typos.toml', '_typos.toml', '.typos.toml', '.git' },
  single_file_support = true,
  settings = {},
  -- workaround of exclude_filetypes
  on_attach = function(_, bufnr)
    local exclude_filetypes = { 'help' }

    if vim.tbl_contains(exclude_filetypes, vim.bo.filetype) then
      vim.diagnostic.enable(false, { bufnr = bufnr })
    end
  end,
}
