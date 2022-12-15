local status, ls = pcall(require, 'luasnip')

if not status then
  vim.notify('Not found L3MON4D3/LuaSnip')
  return
end

vim.keymap.set('i', '<A-l>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

require('luasnip.loaders.from_lua').lazy_load()
require('luasnip.loaders.from_lua').load({ paths = { '~/.config/nvim/snippets' } })
