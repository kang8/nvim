local status, lualine = pcall(require, 'lualine')

if not status then
  vim.notify('Not found nvim-lualine/lualine.nvim')
  return
end

lualine.setup({
  options = {
    section_separators = {},
    component_separators = { '', '|' },
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 3,
      },
    },
    lualine_x = {
      'filetype',
    },
  },
  extensions = { 'nvim-tree', 'toggleterm' },
})
