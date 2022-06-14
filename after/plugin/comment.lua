local status, _ = pcall(require, 'Comment')

if not status then
  vim.notify('Not found numToStr/Comment.nvim')
  return
end

vim.keymap.set('n', '<c-/>', '<CMD>lua require("Comment.api").call("toggle_current_linewise_op")<CR>g@$')
vim.keymap.set('v', '<c-/>', '<ESC><CMD>lua require("Comment.api").locked.toggle_linewise_op(vim.fn.visualmode())<CR>')
