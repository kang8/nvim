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

"=============
" command line
"=============

" %% 与 %:h 的一个按键映射。
" 命令行模式输入 %% 后，会自动转换成当前缓冲区所在目录的路径。
" 值得注意的是，当前目录的路径是针对 :pwd 的相对路径
cnoremap <expr> %% getcmdtype() == ':' ? expand("%:h").'/' : '%%'

" 使用 <C-p> 和 <C-n> 在命令行模式下查找历史命令
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

