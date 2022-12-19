local status, bufferline = pcall(require, 'bufferline')

if not status then
  vim.notify('Not found bufferline.nvim')
  return
end

vim.api.nvim_set_keymap('n', '<leader>gp', ':BufferLinePick<CR>', { noremap = true, silent = true })
-- https://stackoverflow.com/questions/4545275/vim-close-all-buffers-but-this-one
vim.api.nvim_set_keymap('n', '<C-c>', '<cmd>%bd | e# | bd# <CR>', { noremap = true, silent = true })

bufferline.setup({
  options = {
    always_show_bufferline = false,
    -- don't show close icons, because I not use mouse in vim
    show_buffer_close_icons = false,
    show_close_icon = false,

    -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory',
        text_align = 'left',
      },
    },
  },
})
