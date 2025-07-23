return {
  name = 'pyright',
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git',
  },
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'basic',
      },
    },
  },
}
