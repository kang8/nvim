local status, null_ls = pcall(require, 'null-ls')

if not status then
  vim.notify('Not found jose-elias-alvarez/null-ls.nvim')
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  sources = {
    -- Formatting ---------------------
    -- brew install shfmt
    formatting.shfmt,
    -- StyLua
    formatting.stylua,
    -- frontend
    formatting.prettier.with({
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
        'css',
        'scss',
        'less',
        'html',
        'json',
        'yaml',
        'graphql',
      },
      prefer_local = 'node_modules/.bin',
    }),
    -- for rust, install: `rustup component add rustfmt`
    formatting.rustfmt,
  },
})
