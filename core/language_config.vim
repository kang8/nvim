"""""""""""""""
" 语言设置
"""""""""""""""

" %  => 代表整个文件名。 e.g. Hello.java
" %< => 只代表文件名，不加后缀。 e.g. Hello
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
        exec "! javac -d /tmp % && cd /tmp && java %< "
    endif
endfunc

map <leader>r :call ComplieOrRun()<CR>
