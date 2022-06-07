local status, treesitter = pcall(require, "nvim-treesitter.configs")

if not status then
  vim.notify("Not found nvim-treesitter")
  return
end

treesitter.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false, -- 禁用 vim 基于正则达式的语法高亮，太慢
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "toml",
    "php",
    "json",
    "yaml",
    "html",
    "css",
    "javascript",
    "typescript",
    "bash",
    "vim",
    "vue",
    "python",
    "lua",
    "cpp",
    "c",
    "go",
    "rust",
    "java",
    "beancount",
    "dockerfile",
    "http",
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- 默认不要折叠
vim.opt.foldlevel = 99
