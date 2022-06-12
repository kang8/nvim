""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plug 插件管理工具
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plug/.plugged') " 插件列表
if g:is_work != "true\n"
    Plug 'wakatime/vim-wakatime'                           " 记录编码事件插件
endif

Plug 'jiangmiao/auto-pairs'                             " 自动补全括号
Plug 'nvim-lua/plenary.nvim'                            " for git
Plug 'tpope/vim-fugitive'                               " for git
Plug 'lewis6991/gitsigns.nvim'                          " for git
"Plug 'preservim/nerdcommenter'                          " 注释
Plug 'itchyny/vim-cursorword'                           " 使用下划线显示同一个单词
Plug 'tpope/vim-surround'                               " 为 vim 提供修改成对的环绕字符支持
Plug '907th/vim-auto-save'                              " 自动保存
Plug 'lambdalisue/suda.vim'                             " nvim 使用 sudo
Plug 'junegunn/vim-easy-align'                          " 对齐
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }  " prettier format
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " MarkDown 预览
Plug 'kang8/smartim',                                   " macos change inpout method
call plug#end()

source ~/.config/nvim/plug/customized/markdown-preview/markdown-preview.vim
