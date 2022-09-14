local status, sterm = pcall(require, 'sterm')

if not status then
  vim.notify('Not found Hvassaa/sterm.nvim.')
  return
end

sterm.setup({
  split_direction = 'down'
})

vim.keymap.set({'t', 'n'}, "<F14>", sterm.toggle, { silent=true })
