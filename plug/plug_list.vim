""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plug 插件管理工具
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plug/.plugged') " 插件列表
if g:is_work != "true\n"
    Plug 'wakatime/vim-wakatime'                           " 记录编码事件插件
endif

"Plug 'ryanoasis/vim-devicons'                           " icon support
Plug 'jiangmiao/auto-pairs'                             " 自动补全括号
Plug 'Yggdroot/indentLine'                              " 缩进线
Plug 'nvim-lua/plenary.nvim'                            " for git
Plug 'tpope/vim-fugitive'                               " for git
Plug 'lewis6991/gitsigns.nvim'                          " for git
"Plug 'airblade/vim-rooter'                              " Changes Vim working directory to project root.
"Plug 'preservim/nerdcommenter'                          " 注释
"Plug 'ludovicchabant/vim-gutentags'                     " 使用 ctags 管理 tag 文件（必须安装 ctags）
"Plug 'majutsushi/tagbar'                                " 在一个窗口展示 tags
Plug 'itchyny/vim-cursorword'                           " 使用下划线显示同一个单词
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " 使 vim 支持 nodejs，并支持 lsp
Plug 'tpope/vim-surround'                               " 为 vim 提供修改成对的环绕字符支持
"Plug 'gcmt/wildfire.vim'                                " 使用 <ENTER> 来选中块
Plug '907th/vim-auto-save'                              " 自动保存
"Plug 'storyn26383/vim-vue'                              " 为 vim 提供 vue 的支持
"Plug 'jelera/vim-javascript-syntax'                     " 为 vim 提供 js 语法支持
Plug 'lambdalisue/suda.vim'                             " nvim 使用 sudo
Plug 'junegunn/vim-easy-align'                          " 对齐
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }  " prettier format
"Plug 'cespare/vim-toml'                                 " syntax for TOML
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " MarkDown 预览
"Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}         " ranger support方法
Plug 'kang8/smartim',                                   " macos change inpout method
"  Plug 'nathangrigg/vim-beancount',                       " Vim ftplugin for beancount
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'                             " 彩虹括号 by treesitter
"Plug 'rust-lang/rust.vim'
call plug#end()

"source ~/.config/nvim/plug/customized/gutentags.vim
"source ~/.config/nvim/plug/customized/rnvimr.vim
source ~/.config/nvim/plug/customized/markdown-preview/markdown-preview.vim
