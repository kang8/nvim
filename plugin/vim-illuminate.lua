local status, illuminate = pcall(require, 'illuminate')
if not status then
  vim.notify('Not found RRethy/vim-illuminate')
  return
end

illuminate.configure({
  providers = {
    'lsp',
    'treesitter',
    'regex',
  },
  filetypes_denylist = {
    'dirvish',
    'fugitive',
    'NvimTree',
    'packer',
    'dashboard',
  },
})
