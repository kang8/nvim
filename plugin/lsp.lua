local status, mason = pcall(require, 'mason')

if not status then
  vim.notice('Not found williamboman/mason.nvim')
  return
end

mason.setup()

require('mason-lspconfig').setup({
  ensure_installed = { 'sumneko_lua', 'clangd' },
})

require('neodev').setup({})

local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Language TypeScript
nvim_lsp.tsserver.setup({
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
  cmd = { 'typescript-language-server', '--stdio' },
  capabilities = capabilities,
})

-- Language Lua
nvim_lsp.sumneko_lua.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      completion = {
        callSnippet = 'Replace',
      },
      diagnostics = {
        -- Get the language server to recognize the 'vim' global
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false,
      },
      workspaces = {
        -- Make the serve aware of Neovim runtime files
        library = {
          vim.fn.stdpath('data') .. '/site/pack/packer/opt/emmylua-nvim',
          vim.fn.stdpath('config'),
        },
        maxPreload = 2000,
        preloadFileSize = 50000,
      },
    },
  },
  capabilities = capabilities,
})

-- Language C
nvim_lsp.clangd.setup({
  capabilities = capabilities,
})

-- vim-language-server
nvim_lsp.vimls.setup({
  flags = {
    debounce_text_changes = 500,
  },
  capabilities = capabilities,
})

-- bash-language-server
nvim_lsp.bashls.setup({
  capabilities = capabilities,
})

-- php
nvim_lsp.phpactor.setup({
  capabilities = capabilities,
})

-- json
nvim_lsp.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
})
