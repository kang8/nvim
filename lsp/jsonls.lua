return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = {
    '.git',
    'package.json',
  },
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}
