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
    elseif &filetype == 'sh'
        exec "! chmod u+x ./% && ./%"
    elseif &filetype == 'perl'
        exec "! perl %"
    elseif &filetype == 'zsh'
        exec "! zsh %"
    else
        echo "Not support this file type!"
    endif
endfunc

" use :Run to exec ComplieOrRun method
:command Run exec ComplieOrRun()
map <F5> :call ComplieOrRun()<CR>

" 执行 mbedtls 用的命令
:command Mbed exec "! gcc -lmbedtls -lmbedcrypto -lmbedx509 % -o /tmp/%<.out && /tmp/%<.out"
