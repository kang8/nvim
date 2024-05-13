-- Use nvim-treesitter for folding
vim.o.foldlevel = 10
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
