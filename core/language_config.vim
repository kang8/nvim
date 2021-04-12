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
    elseif &filetype == 'javascript'
        exec "! node %"
    elseif &filetype == 'go'
        exec "! go run %"
    endif
endfunc

" run
map <leader>r :call ComplieOrRun()<CR>
" 另外一个运行，因为上面的函数运行完后按下另一个按键后执行结果就会消失
" 所以想重新写一个函数来重新开一个窗口来记录下输出的结果
" out run
" map <leader>or :call ComplieOrRun()<CR>
