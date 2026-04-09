return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = {
    '.git',
    '.gitlab-ci.yml',
    'docker-compose.yml',
    'docker-compose.yaml',
  },
  on_init = function(client)
    client.settings.yaml.schemas = require('schemastore').yaml.schemas()
  end,
  settings = {
    yaml = {
      keyOrdering = false,
    },
  },
}
