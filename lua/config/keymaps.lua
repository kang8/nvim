vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set('i', '<C-b>', '<Left>')
vim.keymap.set({ 'i', 'c' }, '<C-d>', '<Del>')

vim.keymap.set('n', '<F16>', '<cmd>bnext<cr>') -- command + ]
vim.keymap.set('n', '<F17>', '<cmd>bprevious<cr>') -- command + [
