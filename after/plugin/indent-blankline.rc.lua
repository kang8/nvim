local status, ident_blankline = pcall(require, 'indent_blankline')
if not status then
  vim.notify('Not found lukas-reineke/indent-blankline.nvim')
  return
end

vim.opt.listchars:append('space:⋅')

ident_blankline.setup({
  space_char_blankline = ' ',
  -- :echo &filetype
  filetype_exclude = {
    'dashboard',
    'packer',
    'terminal',
    'help',
    'log',
    'markdown',
    'TelescopePrompt',
    'lsp-installer',
    'lspinfo',
    'toggleterm',
  },
  char = '¦',
})
