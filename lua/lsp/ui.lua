vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true, -- 输入会实时开启 lsp 检查
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
