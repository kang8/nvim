return {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  root_markers = { '.taplo.toml', 'taplo.toml', '.git' },
  settings = {
    evenBetterToml = {
      schema = {
        catalogs = { 'https://json.schemastore.org/api/json/catalog.json' },
      },
    },
  },
}
