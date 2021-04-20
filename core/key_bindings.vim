"=============
" 键位设置
"=============

let mapleader=" "

inoremap jj <esc>
inoremap kk <esc>A

map <leader>k :nohl<CR>
map <leader>n :call ChangeDisplayNumber()<CR>

" paste 的切换
set pastetoggle=<leader>p

map <M-c> :bn<CR>
map <Tab> :bn<CR>
