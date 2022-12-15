vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- keybindding
vim.cmd([[ command! Format lua vim.lsp.buf.format{ async = true } ]])

vim.cmd([[ command! Rename :Lspsaga rename ]])
