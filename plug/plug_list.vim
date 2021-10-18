""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plug 插件管理工具
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plug/.plugged') " 插件列表
Plug 'wakatime/vim-wakatime'                           " 记录编码事件插件
if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' } " 支持异步的文件树
else
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'kristijanhusak/defx-icons'                        " defx 图标
Plug 'kristijanhusak/defx-git'                          " defx git 支持
Plug 'hoob3rt/lualine.nvim'                             " 状态栏 support
Plug 'ryanoasis/vim-devicons'                           " icon support
Plug 'jiangmiao/auto-pairs'                             " 自动补全括号
Plug 'Yggdroot/indentLine'                              " 缩进线
Plug 'p00f/nvim-ts-rainbow'                              " 彩虹括号 by treesitter
Plug 'airblade/vim-gitgutter'                           " Git 状态显示
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf support
Plug 'junegunn/fzf.vim'                                 " support fzf on vim
Plug 'airblade/vim-rooter'                              " Changes Vim working directory to project root.
Plug 'morhetz/gruvbox'                                  " theme
Plug 'preservim/nerdcommenter'                          " 注释
Plug 'ludovicchabant/vim-gutentags'                     " 使用 ctags 管理 tag 文件（必须安装 ctags）
Plug 'majutsushi/tagbar'                                " 在一个窗口展示 tags
Plug 'itchyny/vim-cursorword'                           " 使用下划线显示同一个单词
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " 使 vim 支持 nodejs，并支持 lsp
Plug 'tpope/vim-surround'                               " 为 vim 提供修改成对的环绕字符支持
Plug 'gcmt/wildfire.vim'                                " 使用 <ENTER> 来选中块
Plug '907th/vim-auto-save'                              " 自动保存
Plug 'storyn26383/vim-vue'                              " 为 vim 提供 vue 的支持
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'jelera/vim-javascript-syntax'                     " 为 vim 提供 js 语法支持
Plug 'lambdalisue/suda.vim'                             " nvim 使用 sudo
Plug 'junegunn/vim-easy-align'                          " 对齐
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }  " prettier format
Plug 'cespare/vim-toml'                                 " syntax for TOML
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " MarkDown 预览
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}         " ranger support
call plug#end()
