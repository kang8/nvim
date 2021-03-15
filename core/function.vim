"=============
" 自定义函数
"=============

fun! ChangeDisplayNumber()
    if (&relativenumber == 1)
        set norelativenumber nonumber
    else
        set relativenumber number
    endif
endfun
