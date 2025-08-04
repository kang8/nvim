vim.api.nvim_create_user_command('SpaceTo', function(opts)
  local char = opts.args
  vim.cmd(string.format('s/\\%%V /%s/g', char))
end, { range = true, nargs = 1 })

-- Copy selected lines in @File#L1-99 format to clipboard
vim.api.nvim_create_user_command('CCLine', function(opts)
  local file_path = vim.fn.expand('%:p')
  local relative_path = vim.fn.fnamemodify(file_path, ':.')

  local format
  -- Check if called with a range (visual mode)
  if opts.range > 0 then
    local start_line = opts.line1
    local end_line = opts.line2

    if start_line == end_line then
      format = string.format('@%s#L%d', relative_path, start_line)
    else
      format = string.format('@%s#L%d-%d', relative_path, start_line, end_line)
    end
  else
    format = string.format('@%s', relative_path)
  end

  vim.fn.setreg('+', format)
  vim.notify('Copied: ' .. format)
end, { range = true })
