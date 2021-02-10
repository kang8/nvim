"""""""""""""""
" 语言设置
"""""""""""""""

func! ComplieOrRun()
    exec "w"
    if &filetype == 'c'
        exec "! gcc % -o /tmp/%<.out && /tmp/%<.out"
    elseif &filetype == 'cpp'
        exec "! g++ % -o /tmp/%<.out && /tmp/%<.out"
    elseif &filetype == 'python'
        exec "! python3 %"
    elseif &filetype == 'php'
        exec "! php %"
    elseif &filetype == 'java'
        exec "! javac % && java %<"
    endif
endfunc

map <leader>r :call ComplieOrRun()<CR>
