vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.scrolloff = 999

vim.keymap.set({ 'n', 'x' }, 'd', '<C-d>', { buf = 0 })
vim.keymap.set({ 'n', 'x' }, 'u', '<C-u>', { buf = 0 })
