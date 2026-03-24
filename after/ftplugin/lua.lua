-- Use nvim-treesitter for folding
vim.opt_local.foldlevel = 10
vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
