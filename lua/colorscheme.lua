local status = pcall(require, "tokyonight")

if not status then
  vim.notify("Not found folke/tokyonight.nvim")
  return
end

vim.cmd[[colorscheme tokyonight-day]]
