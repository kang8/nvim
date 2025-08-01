return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
  root_markers = {
    '.git',
    '.gitlab-ci.yml',
    'docker-compose.yml',
    'docker-compose.yaml',
  },
  settings = {
    yaml = {
      keyOrdering = false,
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
