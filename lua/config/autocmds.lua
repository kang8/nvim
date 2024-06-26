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

-- Set spell check when using git to commit
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'COMMIT_EDITMSG',
  callback = function()
    vim.cmd([[
      set spell
      syntax match diffComment /^#.*/  contains=@Spell
    ]])

    -- When writing commit message, cursor remains at the top of the line
    vim.cmd([[normal gg]])
  end,
  group = vim.api.nvim_create_augroup('SpellCheck', { clear = true }),
})

-- When file suffix is `.cls` or `.trigger` and file_path include 'salesforce' then set filetype to `apex`
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.cls', '*.trigger' },
  callback = function(args)
    local absolute_file_path = args.match
    if string.match(absolute_file_path, 'salesforce') then
      vim.bo.filetype = 'apex'
    end
  end,
})
