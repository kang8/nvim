-- Emacs Keybinding
vim.keymap.set({ 'i', 'c' }, '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-f>', '<Right>')
vim.keymap.set({ 'i', 'c' }, '<C-b>', '<Left>')

-- Quick move buffers
vim.keymap.set('n', '<D-]>', '<cmd>bnext<cr>')
vim.keymap.set('n', '<D-[>', '<cmd>bprevious<cr>')

-- HL as amplified versions of hl
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

vim.opt.scrolloff = 3 -- no more need for HML keys

-- spell
vim.keymap.set('n', 'za', '1z=') -- fix word under cursor

-- unset default keymap
vim.keymap.set('n', '<F1>', '<Nop>')

-- Toggle casing
vim.keymap.set('n', '<leader>u', 'mzlblgueh~`z', { desc = 'Toggle the case of the first char' })

-- Keep emacs key in cmdline, and replace <C-f> as <C-l>
vim.keymap.set('c', '<C-l>', '<C-f>')
vim.keymap.set('c', '<C-f>', '<Right>')

-- Fast finger fixes
vim.cmd([[
cabbrev Q  quit
cabbrev W  update
cabbrev WQ exit
cabbrev Wq exit
cabbrev QA quitall
cabbrev Qa quitall
cabbrev Q!  quit!
cabbrev W!  update!
cabbrev WQ! exit!
cabbrev Wq! exit!
cabbrev QA! quitall!
cabbrev Qa! quitall!
]])

-- smart dd, only yank the line if it's not empty
vim.keymap.set('n', 'dd', function()
  if vim.fn.getline(vim.fn.line('.')) == '' then
    return '"_dd'
  end
  return 'dd'
end, { expr = true })

-- Search within last selection
vim.keymap.set({ 'n', 'v' }, '<A-/>', '<Esc>/\\%V', { desc = 'Search within last selection' })

-- Delete the current buffer(like another editor)
vim.api.nvim_set_keymap('n', '<D-w>', ':bd<CR>', { noremap = true, silent = true, desc = 'Delete the current buffer' })
