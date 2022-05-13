"----------------------------------------------------------------------
" 键位设置
"----------------------------------------------------------------------

let mapleader=" "

inoremap jj <esc>
inoremap kk <esc>A

map <leader>k :nohl<CR>
map <leader>n :call ToggleDisplayNumber()<CR>
map <leader>l :call ToggleWrap()<CR>

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

"----------------------------------------------------------------------
" INSERT 模式下使用 EMACS 键位
"----------------------------------------------------------------------
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>
inoremap <c-_> <c-k>
inoremap <c-f> <Right>
inoremap <c-b> <Left>

"----------------------------------------------------------------------
" 命令模式的快速移动
"----------------------------------------------------------------------
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-f> <c-d>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-_> <c-k>
cnoremap <c-p> <Up>
cnoremap <c-n> <Down>
