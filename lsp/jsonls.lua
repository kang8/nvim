return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  root_markers = {
    '.git',
    'package.json',
  },
  on_init = function(client)
    client.settings.json.schemas = require('schemastore').json.schemas()
  end,
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
}
