vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('kang', {}),
  desc = 'Restore last cursor position',
  callback = function(args)
    local bufnr = args.buf
    local line, col = unpack(vim.api.nvim_buf_get_mark(bufnr, '"'))
    local winid = vim.api.nvim_get_current_win()

    local end_line = vim.api.nvim_buf_line_count(bufnr)
    local end_col = #vim.api.nvim_buf_get_lines(bufnr, end_line - 1, end_line, true)[1]
    if line < end_line or (line == end_line and col <= end_col) then
      vim.api.nvim_win_set_cursor(winid, { line, col })
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
