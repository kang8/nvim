local status, bufferline = pcall(require, "bufferline")

if not status then
  vim.notify("Not found bufferline.nvim")
  return
end

vim.api.nvim_set_keymap("n", "gp", ":BufferLinePick<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cl", ":BufferLineCloseRight<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ch", ":BufferLineCloseLeft<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cp", ":BufferLinePickClose<CR>", {noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-c>", ":BufferLineCloseRight<CR> :BufferLineCloseLeft<CR>", {noremap = true, silent = true })

bufferline.setup({
  options = {
    -- don't show close icons, because I not use mouse in vim
    show_buffer_close_icons = false,
    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
      },
    },
    -- 使用 nvim 内置 LSP
    diagnostics = "nvim_lsp",
    -- 显示 LSP 报错图标
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "")
        s = s .. n .. sym
      end
      return s
    end,
  },
})
