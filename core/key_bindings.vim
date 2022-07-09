let mapleader=" "
let maplocalleader=" "

map <leader>n :call ToggleDisplayNumber()<CR>
map <leader>l :call ToggleWrap()<CR>

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
" cnoremap <c-f> <c-d> " Do not use <c-d> override command mode, Because it will open command-line window. :h c_CTRL-F
cnoremap <c-b> <left>
" cnoremap <c-d> <del> " Do not use <c-d> override command mode, Because it will expand all match option
cnoremap <c-_> <c-k>
cnoremap <c-p> <Up>
cnoremap <c-n> <Down>

"----------------------------------------------------------------------
" 窗口切换：ALT+SHIFT+hjkl
" 传统的 CTRL+hjkl 移动窗口不适用于 vim 8.1 的终端模式，CTRL+hjkl 在
" bash/zsh 及带文本界面的程序中都是重要键位需要保留，不能 tnoremap 的
"----------------------------------------------------------------------
noremap <m-H> <c-w>h
noremap <m-L> <c-w>l
noremap <m-J> <c-w>j
noremap <m-K> <c-w>k
inoremap <m-H> <esc><c-w>h
inoremap <m-L> <esc><c-w>l
inoremap <m-J> <esc><c-w>j
inoremap <m-K> <esc><c-w>k

if has('terminal') && exists(':terminal') == 2 && has('patch-8.1.1') " vim 8.1 支持 termwinkey ，不需要把 terminal 切换成 normal 模式
    " 设置 termwinkey 为 CTRL 加减号（GVIM），有些终端下是 CTRL+?
    " 后面四个键位是搭配 termwinkey 的，如果 termwinkey 更改，也要改
    set termwinkey=<c-_>
    tnoremap <m-H> <c-_>h
    tnoremap <m-L> <c-_>l
    tnoremap <m-J> <c-_>j
    tnoremap <m-K> <c-_>k
    tnoremap <m-q> <c-\><c-n>
elseif has('nvim')
    " neovim 没有 termwinkey 支持，必须把 terminal 切换回 normal 模式
    lua vim.api.nvim_set_keymap("n", "<leader>tm", ":sp | terminal<CR>", {noremap = true, silent = ture})
    tnoremap <m-H> <c-\><c-n><c-w>h
    tnoremap <m-L> <c-\><c-n><c-w>l
    tnoremap <m-J> <c-\><c-n><c-w>j
    tnoremap <m-K> <c-\><c-n><c-w>k
    tnoremap <Esc> <c-\><c-n>
endif

"----------------------------------------------------------------------
" For visual mode
"----------------------------------------------------------------------
" 使用 >/< 依然留在 visual mode 下
vnoremap <silent>> >gv
vnoremap <silent>< <gv
" 使用 control j/k 移动选中的行
vnoremap <c-j> :move '>+1<CR>gv
vnoremap <c-k> :move '<-2<CR>gv
" 在 visual 模式里粘贴不要复制
vnoremap p "_dP

"----------------------------------------------------------------------
" For buffer move
"----------------------------------------------------------------------
nnoremap <silent> <c-j> :bn<CR>
nnoremap <silent> <c-k> :bp<CR>
