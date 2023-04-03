-- Emacs Keybinding
vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set({ 'i', 'c' }, '<C-d>', '<Del>')
vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>')

vim.keymap.set('n', '<F16>', '<cmd>bnext<cr>') -- command + ]
vim.keymap.set('n', '<F17>', '<cmd>bprevious<cr>') -- command + [

-- HJKL as amplified versions of hjkl
vim.keymap.set('n', 'J', '6j')
vim.keymap.set('n', 'K', '6k')
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

vim.opt.scrolloff = 15 -- no more need for HML keys
vim.keymap.set('n', 'M', 'J') -- mnemonic: [M]erge
vim.keymap.set('n', '<leader>h', 'K') -- mnemonic: [h]over

-- spell
vim.keymap.set('n', 'za', '1z=') -- fix word under cursor
