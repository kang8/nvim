vim.opt.number = false
vim.opt.relativenumber = false
vim.opt.scrolloff = 999

vim.keymap.set({ 'n', 'x' }, 'd', '<C-d>')
vim.keymap.set({ 'n', 'x' }, 'u', '<C-u>')
vim.keymap.set({ 'n', 'x' }, 'f', '<C-f>') -- Will override default mation hehavior, if it interferes with the use, need to be commented
vim.keymap.set({ 'n', 'x' }, 'b', '<C-b>') -- Will override default mation hehavior, if it interferes with the use, need to be commented
