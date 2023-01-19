local contained, numb = pcall(require, 'numb')

if not contained then
  vim.notify('Not found numb', vim.log.levels.WARN)
  return
end

numb.setup()
