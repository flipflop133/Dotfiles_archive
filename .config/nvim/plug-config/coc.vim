let g:coc_global_extensions = [
            \ 'coc-snippets',
	    \ 'coc-dictionary',
            \ 'coc-word',
            \ 'coc-syntax',
            \ 'coc-ultisnips',
            \ 'coc-neosnippet',
            \ 'coc-python',
            \ 'coc-pairs',
            \ 'coc-tabnine',
            \ 'coc-css',
            \ 'coc-prettier'
            \]
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
