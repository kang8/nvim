if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
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
    "bash",
    "vim",
    "python",
    "lua",
    "cpp",
    "c",
    "go",
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  },
}

EOF
