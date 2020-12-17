let g:coc_global_extensions = [
            \ 'coc-snippets',
	    \ 'coc-dictionary',
            \ 'coc-word',
            \ 'coc-syntax',
            \ 'coc-ultisnips',
            \ 'coc-neosnippet',
            \ 'coc-python',
            \ 'coc-pairs',
            \ 'coc-tabnine'
            \]
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
