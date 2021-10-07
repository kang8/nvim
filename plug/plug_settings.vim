" ===
" === gruvbox color theme
" ===
colorscheme gruvbox
set termguicolors

" ===
" vim-gitgutter
" ===
set updatetime=10
let g:gitgutter_sign_added = '▒ '
"let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░ '
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒ '

" ===
" Shougo/defx.nvim
" ===
nmap <silent> <leader>d :Defx <CR>

function! s:defx_mappings() abort
  nnoremap <silent><buffer><expr> <CR>
      \ defx#is_directory() ?
      \ defx#do_action('open_or_close_tree') :
      \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> o
      \ defx#is_directory() ?
      \ defx#do_action('open_or_close_tree') :
      \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
      \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
      \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
      \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> E
      \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> l
      \ defx#is_directory() ? defx#do_action('open') : 0
  nnoremap <silent><buffer><expr> h
      \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> K
      \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
      \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> C
      \ defx#do_action('toggle_columns',
      \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> d
      \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> !
      \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
      \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
      \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> r
      \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> q
      \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> .
      \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ~
      \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> <Space>
      \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
      \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> <C-l>
      \ defx#do_action('redraw')
endfunction

call defx#custom#option('_', {
    \ 'columns': 'indent:git:space:icons:space:filename:mark',
    \ 'winwidth': 30,
    \ 'split': 'vertical',
    \ 'direction': 'topleft',
    \ 'show_ignored_files': 0,
    \ 'toggle': 1,
    \ 'root_marker': '≡ '
    \ })

call defx#custom#column('indent', {
    \ 'indent': "  ",
    \ })

call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : 'M',
  \ 'Staged'    : 'S',
  \ 'Untracked' : 'U',
  \ 'Renamed'   : 'R',
  \ 'Ignored'   : 'I',
  \ 'Deleted'   : 'D',
  \ })

autocmd FileType defx call s:defx_mappings()

" ===
" vim-airline/vim-airline state pretty
" ===
let g:airline#extensions#tabline#enabled=1

" ===
" majutsushi/ragbar tag tree setting
" ===
nmap <leader>t :TagbarToggle<CR>

" ===
" 907th/vim-auto/save
" ===
let g:auto_save = 1
" 不想要自动保存的文件
augroup no_auto_save_file
    au!
    au BufEnter COMMIT_EDITMSG let b:auto_save = 0
augroup END

let g:auto_save_silent = 1

" ===
" ludovicchabant/vim-gutentags
" ===
let g:gutentags_project_root = ['.root', '.svn', '.git']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" ===
" luochen1990/rainbow
" ===
let g:rainbow_active = 1 "open rainbow


" ===
" treesitter
" ===
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"html","css","javascript","json","vue","bash"},
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {
    enable = true
  }
}
EOF

" ===
" nowclide/nvim.coc
" ===
let g:coc_global_extensions = []

" 当文件没有保存时，也可以跳转到其他文件去
set hidden
set updatetime=100

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> <LEADER>h :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" nmap <leader>rn <Plug>(coc-rename)

" ===
" === suda.vim
" ===
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%

" ===
" === indentline
" ===
let g:indentLine_fileTypeExclude = ['json', 'markdown', 'md']

let s:box_drawings_light_vertical = '|'

let g:indentLine_char = s:box_drawings_light_vertical

" ===
" === indentline
" ===
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ===
" === vim-prettier
" ===
" <Ctrl + Alt + L> 快捷键调用 prettier 格式化
nmap <C-M-L> :Prettier<CR>

" ===
" === nerdcommenter
" ===
let g:NERDSpaceDelims=1
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle

" ===
" === markdown-preview.nvim
" ===
" 获取当前脚本的绝对路径
let s:current_path=expand("<sfile>:h")
let g:mkdp_markdown_css = s:current_path . '/custom-markdown.css'

" ===
" === kevinhwang91/rnvimr
" ===
" Make Ranger replace netrw and be the file explorer
let g:rnvimr_enable_ex = 1

nmap <space>r :RnvimrToggle<CR>

" ===
" === junegunn/fzf.vim
" ===
nmap <leader>p :Files<CR>
