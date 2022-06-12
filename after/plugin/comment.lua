local status, comment = pcall(require, 'Comment')

if not status then
  vim.notify('Not found numToStr/Comment.nvim')
  return
end

comment.setup({
  toggler = {
    line = '<c-/>',
  },
  opleader = {
    line = '<c-/>',
  },
})
