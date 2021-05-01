" ===
" === gruvbox color theme
" ===
colorscheme gruvbox
set termguicolors

" ===
" vim-gitgutter
" ===
set updatetime=10
let g:gitgutter_sign_added = '▒▒'
"let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒▒'

" ===
" scrooloose/nerdtree. directory tree setting
" ===
let NERDTreeShowHidden=1
let NERDTreeWinSize=30
nmap <leader>d :NERDTreeToggle<CR>


" ===
" vim-airline/vim-airline state pretty
" ===
let g:airline#extensions#tabline#enabled=1

let g:airline_powerline_fonts=1

" ===
" majutsushi/ragbar tag tree setting
" ===
nmap <leader>t :TagbarToggle<CR>

" ===
" 907th/vim-auto/save
" ===
let g:auto_save = 1

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
nmap <leader>rn <Plug>(coc-rename)

" ===
" === suda.vim
" ===
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%
