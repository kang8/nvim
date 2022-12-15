local status, null_ls = pcall(require, 'null-ls')

if not status then
  vim.notify('Not found jose-elias-alvarez/null-ls.nvim')
  return
end

local formatting = null_ls.builtins.formatting
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

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
    formatting.clang_format,
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_buf_create_user_command(bufnr, 'LspFormatting', function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, {})

      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        command = 'undojoin | LspFormatting',
      })
    end
  end,
})
