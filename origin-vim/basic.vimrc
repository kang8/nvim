" vim -u /path/basic.vimrc
set nocompatible
set t_RV=

syntax on
filetype on
filetype indent on

set nobackup
set visualbell t_vb=
set novisualbell

set showcmd
set showmode
set ruler
set nu rnu

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

set list listchars=eol:¬,tab:▸\ ,trail:·,

set encoding=utf-8

colorscheme elfload
set background=dark
set t_Co=256