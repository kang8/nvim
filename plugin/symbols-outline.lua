local status, outline = pcall(require, 'symbols-outline')
if not status then
  vim.notify('Not found simrat39/symbols-outline.nvim', vim.log.levels.WARN)
  return
end

outline.setup()

vim.keymap.set('n', '<leader>a', '<cmd>SymbolsOutline<CR>')
