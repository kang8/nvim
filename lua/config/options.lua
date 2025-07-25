vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard:append({ 'unnamedplus' })
vim.opt.sidescrolloff = 6
vim.opt.wildmode = { 'list:longest', 'full' }
vim.opt.listchars = { tab = '>·', nbsp = '+', trail = '·', extends = '→', precedes = '←' }
vim.opt.showbreak = '↪'
vim.opt.fillchars = { diff = '/' }
vim.opt.mousescroll = { 'ver:1', 'hor:0' }

-- full file path & vim mode in window title
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = '%{expand("%:p")} [%{mode()}]'

-- Search and Replace
vim.opt.inccommand = 'split' -- "for incsearch while sub

vim.diagnostic.config({
  virtual_text = { current_line = false },
  virtual_lines = { current_line = true },
})

if vim.fn.has('nvim-0.12') == 1 and not vim.g.vscode then
  require('vim._extui').enable({})
end

vim.opt.maxsearchcount = 9999
