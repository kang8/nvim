vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.scrolloff = 999

vim.keymap.set({ 'n', 'x' }, 'd', '<C-d>', { buffer = true })
vim.keymap.set({ 'n', 'x' }, 'u', '<C-u>', { buffer = true })
