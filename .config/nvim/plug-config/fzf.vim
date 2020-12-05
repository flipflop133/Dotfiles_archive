" Mappings
:nnoremap <Leader>b :Buffers <ENTER>
:nnoremap <Leader>w :Windows <ENTER>
:nnoremap <Leader>f :Files <ENTER>
:nnoremap <Leader>l :Lines <ENTER>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Preview files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', 'cat {}']}, <bang>0)
