" ===
" vim-gitgutter
" ===
set updatetime=10
let g:gitgutter_sign_added = '▒ '
let g:gitgutter_sign_modified = '░ '
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒ '

" ===
" === gutentags
" ===
let g:gutentags_project_root = ['.root', '.svn', '.git']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

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
