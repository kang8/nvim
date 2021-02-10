set nocompatible
set t_RV=
set shortmess=atI

syntax on
filetype on
filetype indent on

set visualbell t_vb=
set novisualbell
set nobackup
set noswapfile
set undofile

set showcmd
set showmode
set ruler
set nu rnu

set hlsearch
set incsearch
set showmatch
set matchtime=1
set ignorecase
set smartcase

set scrolloff=3
set backspace=indent,eol,start

set expandtab
set smarttab autoindent smartindent
set shiftwidth=4 tabstop=4 softtabstop=4
set wrap
set linebreak

set list listchars=eol:¬,tab:▸\ ,trail:·,

set encoding=utf-8

set background=dark
colorscheme elfload
set guifont=Consolas:h14
set t_Co=256
set mapleader=" "
set g:mapleader=" "

autocmd filetype javascript,html,css,xml set tabstop=2 shiftwidth=2 softtabstop=2