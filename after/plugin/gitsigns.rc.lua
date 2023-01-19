local status, gitsigns = pcall(require, 'gitsigns')
if not status then
  vim.notify('Not found gitsigns')
  return
end

gitsigns.setup()
