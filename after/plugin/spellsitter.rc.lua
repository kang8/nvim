local status, spellsitter = pcall(require, 'spellsitter')

if not status then
  vim.notify('Not found lewis6991/spellsitter.nvim')
  return
end

spellsitter.setup({})
