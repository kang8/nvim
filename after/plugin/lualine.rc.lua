local status, lualine = pcall(require, "lualine")

if not status then
  vim.notify("Not found lualnie.nvim")
  return
end

lualine.setup {
  options = {
    section_separators = {},
    component_separators = {'', '|'},
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true,
        path = 3
      },
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
    },
    lualine_x = {
      'filesize',
      {
        "fileformat",
        symbols = {
          unix = "LF",
          dos = "CRLF",
          mac = "CR",
        },
      },
      'encoding',
      'filetype',
    },
  },
  extensions = { "nvim-tree", "toggleterm" }
}
