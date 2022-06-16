local status, autopairs = pcall(require, 'nvim-autopairs')

if not status then
  vim.notify('Not found windwp/nvim-autopairs')
  return
end

autopairs.setup({})
