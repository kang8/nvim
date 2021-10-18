let colors = getcompletion('', 'color')

for color in colors
    if (color == "gruvbox")
        colorscheme gruvbox
        set background=dark
    endif
endfor
