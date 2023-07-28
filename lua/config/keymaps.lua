-- Emacs Keybinding
vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set({ 'i', 'c' }, '<C-d>', '<Del>')
vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>')

vim.keymap.set('n', '<D-]>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<D-[>', '<cmd>bprevious<cr>')

-- HL as amplified versions of hl
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

vim.opt.scrolloff = 15 -- no more need for HML keys

-- spell
vim.keymap.set('n', 'za', '1z=') -- fix word under cursor

-- unset default keymap
vim.keymap.set('n', '<F1>', '<Nop>')

-- Toggle casing
vim.keymap.set('n', '<leader>u', 'mzlblgueh~`z')
