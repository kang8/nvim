"""""""""""""""
" 语言设置
"""""""""""""""

func! ComplieAndRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "!time ./%<"
    if &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    endif
endfunc
