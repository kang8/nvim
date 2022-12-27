require('mini.indentscope').setup({})

vim.cmd([[ autocmd Filetype markdown,help lua vim.g.miniindentscope_disable = true ]])

require('mini.trailspace').setup({})
