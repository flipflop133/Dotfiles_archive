"########################
"# NEOVIM CONFIGURATION # 
"########################
" Theme
set background=light
colorscheme PaperColor 

" UI configuration
set number

" Clipboard
set clipboard=unnamedplus

" Map the leader key to SPACE
let mapleader="\<SPACE>"

" spell languages
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
set spelllang=en

