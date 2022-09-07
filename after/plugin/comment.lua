local status, _ = pcall(require, 'Comment')

if not status then
  vim.notify('Not found numToStr/Comment.nvim')
  return
end

vim.keymap.set('n', '<c-/>', '<Plug>(comment_toggle_linewise_current)')
vim.keymap.set('x', '<c-/>', '<Plug>(comment_toggle_linewise_visual)')
