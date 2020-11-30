"########################
"# NEOVIM CONFIGURATION # 
"########################
" Theme
"https://github.com/NLKNguyen/papercolor-theme
set termguicolors
set background=light "termguicolors
colorscheme PaperColor 

" copy/paste
set clipboard=unnamedplus
" UI configuration
syntax on
syntax enable
if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif
set number
"set relativenumber
set hidden
set mouse=a
set noshowmode
set noshowmatch
set nolazyredraw
" Turn off backup
set nobackup
set noswapfile
set nowritebackup
" Search configuration
set ignorecase                    " ignore case when searching
set smartcase                     " turn on smartcase
" Tab and Indent configuration
set expandtab
set tabstop=4
set shiftwidth=4

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" spell languages
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
set spelllang=en

" Give more space for displaying messages.
set cmdheight=2

" Disable completion scratch
set completeopt-=preview

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Transparent background
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight number ctermbg=NONE guibg=NONE

