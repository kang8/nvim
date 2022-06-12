local status, ident_blankline = pcall(require, "indent_blankline")
if not status then
  vim.notify("Not found lukas-reineke/indent-blankline.nvim")
  return
end

vim.opt.listchars:append("space:⋅")

ident_blankline.setup({
  -- 空行占位
  space_char_blankline = " ",
  -- 用 treesitter 判断上下文
  show_current_context = true,
  show_current_context_start = true,
  -- :echo &filetype
  filetype_exclude = {
    "dashboard",
    "packer",
    "terminal",
    "help",
    "log",
    "markdown",
    "TelescopePrompt",
    "lsp-installer",
    "lspinfo",
    "toggleterm",
  },
  -- 竖线样式
  -- char = '¦'
  -- char = '┆'
  -- char = '│'
  -- char = "⎸",
  -- char = "▏",
  char = "¦",
})
