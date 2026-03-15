return {
  name = 'ty',
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'ty.toml',
    '.ty.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    '.git',
  },
  single_file_support = true,
}
