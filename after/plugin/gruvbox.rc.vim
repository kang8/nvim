let colors = getcompletion('', 'color')

for color in colors
    if (color == "gruvbox")
        colorscheme gruvbox
        set background=dark
        " unset background
        hi Normal guibg=NONE
    endif
endfor
