-- go to last lockmarks when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'COMMIT_EDITMSG',
  callback = function()
    vim.cmd([[
      set spell
      syntax match diffComment /^#.*/  contains=@Spell
    ]])
  end,
  group = vim.api.nvim_create_augroup('SpellCheck', { clear = true }),
})

-- When file suffix is `.cls` set filetype to `apex`
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.cls',
  callback = function()
    vim.bo.filetype = 'apex'
  end,
})
