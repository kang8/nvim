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
