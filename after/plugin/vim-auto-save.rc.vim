let g:auto_save = 1
" 不想要自动保存的文件
augroup no_auto_save_file
    au!
    au BufEnter COMMIT_EDITMSG let b:auto_save = 0
augroup END

let g:auto_save_silent = 1
