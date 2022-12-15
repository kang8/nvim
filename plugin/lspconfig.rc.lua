local status, nvim_lsp = pcall(require, 'lspconfig')

if not status then
  vim.notice('Not found neovim/nvim-lspconfig')
  return
end

-- Language TypeScript
nvim_lsp.tsserver.setup({
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'typescript-language-server', '--stdio' },
})

-- Language Lua
nvim_lsp.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = { 'vim' },
      },

      workspaces = {
        -- Make the serve aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
})

-- Language C
nvim_lsp.clangd.setup({})
