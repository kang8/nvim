if !exists('g:loaded_defx') | finish | endif

" map <silent> <leader>d :Defx <CR>
map <silent> <leader>d :<C-u>Defx -listed -resume
      \ -buffer-name=tab`tabpagenr()`
      \ `expand('%:p:h')` -search=`expand('%:p')`<CR>

function! s:defx_mappings() abort
  nnoremap <silent><buffer><expr> <CR>
      \ defx#is_directory() ?
      \ defx#do_action('open_or_close_tree') :
      \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> o
      \ defx#is_directory() ?
      \ defx#do_action('open_or_close_tree') :
      \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> c
      \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
      \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
      \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> E
      \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> l
      \ defx#is_directory() ? defx#do_action('open') : 0
  nnoremap <silent><buffer><expr> h
      \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> K
      \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
      \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> C
      \ defx#do_action('toggle_columns',
      \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> d
      \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> !
      \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
      \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
      \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> r
      \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> q
      \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> .
      \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ~
      \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> <Space>
      \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
      \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> <C-l>
      \ defx#do_action('redraw')
endfunction

call defx#custom#option('_', {
    \ 'columns': 'indent:git:space:icons:space:filename:mark',
    \ 'winwidth': 30,
    \ 'split': 'vertical',
    \ 'direction': 'topleft',
    \ 'show_ignored_files': 0,
    \ 'toggle': 1,
    \ 'root_marker': '≡ '
    \ })

call defx#custom#column('indent', {
    \ 'indent': "  ",
    \ })

call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : 'M',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })

autocmd FileType defx call s:defx_mappings()
