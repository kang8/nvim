if !exists('g:loaded_quick_scope') 
  echo "Not found unblevable/quick-scope"
endif

nmap <leader>q <plug>(QuickScopeToggle)
xmap <leader>q <plug>(QuickScopeToggle)

let g:qs_enable=0
