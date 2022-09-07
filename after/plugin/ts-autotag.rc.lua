local status, autotag = pcall(require, 'nvim-ts-autotag')

if not status then
  vim.notify('Not found windwp/nvim-ts-autotag')
  return
end

autotag.setup({})
