" vim -u /path/basic.vimrc
set nocompatible
set t_RV=

syntax on
filetype on
filetype plugin on
filetype indent on

set nobackup
set visualbell t_vb=
set novisualbell

set showcmd
set showmode
set ruler
" 显示行号
"set nu rnu

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set matchtime=1

set scrolloff=3
set backspace=indent,eol,start
" set runtimepath=$VIMRUNTIME


set expandtab
set smarttab autoindent smartindent
set shiftwidth=4 tabstop=4 softtabstop=4

set list listchars=eol:⏎,tab:>-,trail:·

set encoding=utf-8

set termguicolors
set t_Co=256

au BufNewFile,BufRead *.html,*.js,*.vue,*.css,*.json,*.yml,*.yaml,*.xml,*.lua set tabstop=2 softtabstop=2 shiftwidth=2

set cursorline

" 记住上次编辑的历史
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

set undofile
set undodir=/tmp

" fileformat 文件换行符
set ff=unix

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if has('unix') && executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" Use the clipboard register '*' (primary selection)
set clipboard=unnamed
if has('unnamedplus')
  " Use X11 CLIPBOARD selection, register '+' (clipboard selection)
  " NOTE: in alacritty use <C-S-V> to paste
  set clipboard=unnamedplus
endif

let g:is_work = system("echo $is_work")
