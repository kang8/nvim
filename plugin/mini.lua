require('mini.indentscope').setup({})

vim.cmd([[ autocmd Filetype markdown,help lua vim.g.miniindentscope_disable = true ]])

require('mini.trailspace').setup({})

require('mini.tabline').setup({})
-- https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>%bd | e# | bd# <CR>', { noremap = true, silent = true })
