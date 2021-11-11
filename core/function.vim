"=============
" 自定义函数
"=============

fun! ToggleDisplayNumber()
    if (&relativenumber == 1)
        set norelativenumber nonumber
    else
        set relativenumber number
    endif
endfun

fun! ToggleWrap()
    if (&wrap == 1)
        set nowrap
    else
        set wrap
    endif
endfun
