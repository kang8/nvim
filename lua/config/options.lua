vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard:append({ 'unnamedplus' })
vim.opt.wrap = false
vim.opt.sidescrolloff = 6
-- 'scrolloff' itself is set in keymaps.lua
vim.opt.scrolloffpad = 1 -- with 'scrolloff', keep cursor centered even at end of file
vim.opt.shortmess:append('u') -- silence undo/redo messages
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

-- CursorHold fires after this many ms idle (default 4000). That default is a
-- legacy Vim value meant for swap-file writes; it also gates diagnostic
-- virtual_lines `current_line`, which otherwise appears ~4s late. 100ms = snappy.
vim.o.updatetime = 100

vim.diagnostic.config({
  virtual_text = { current_line = false, source = true },
  virtual_lines = { current_line = true },
  float = { source = true },
  severity_sort = true,
  signs = {
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
    },
  },
})

if not vim.g.vscode then
  require('vim._core.ui2').enable({})
end

vim.opt.maxsearchcount = 9999
