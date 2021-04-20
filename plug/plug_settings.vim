" gruvbox color theme
colorscheme gruvbox

" airblade/vim-gitgutter. Git setting
set updatetime=10

" scrooloose/nerdtree. directory tree setting
let NERDTreeShowHidden=1
let NERDTreeWinSize=30
nmap <leader>d :NERDTreeToggle<CR>


" vim-airline/vim-airline state pretty
let g:airline#extensions#tabline#enabled=1

let g:airline_powerline_fonts=1

" majutsushi/ragbar tag tree setting
nmap <leader>t :TagbarToggle<CR>

" 907th/vim-auto/save
let g:auto_save = 1

" ludovicchabant/vim-gutentags
let g:gutentags_project_root = ['.root', '.svn', '.git']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" luochen1990/rainbow
let g:rainbow_active = 1 "open rainbow
