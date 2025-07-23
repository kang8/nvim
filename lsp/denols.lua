return {
  name = 'denols',
  cmd = { 'deno', 'lsp' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_markers = {
    'deno.json',
    'deno.jsonc',
  },
  single_file_support = true,
  init_options = {
    enable = true,
    lint = true,
    unstable = true,
  },
  settings = {},
}
