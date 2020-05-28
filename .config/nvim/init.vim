
"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

"###########
"# PLUGINS #
"###########
"VIM PLUG
"https://github.com/junegunn/vim-plug
call plug#begin()

" Theme
Plug 'NLKNguyen/papercolor-theme'

" UI stuff
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Better Visual Guide
Plug 'Yggdroot/indentLine'

" Linter
Plug 'dense-analysis/ale'

" Autocomplete
Plug 'zchee/deoplete-jedi'
Plug 'jiangmiao/auto-pairs'

" FORMATER
" :Autoformat
Plug 'Chiel92/vim-autoformat'

" Code jump
Plug 'davidhalter/jedi-vim'

" File manager and explorer
" :NERDTree
Plug 'scrooloose/nerdtree'

" Code folding
Plug 'tmhedberg/SimpylFold'
call plug#end()

"########################
"# NEOVIM CONFIGURATION # 
"########################
" Theme
"https://github.com/NLKNguyen/papercolor-theme
set t_Co=256   " This is may or may not needed.
set background=light
colorscheme PaperColor

" copy/paste
set clipboard=unnamedplus
" UI configuration
syntax on
syntax enable
" colorscheme
"let base16colorspace=256
"colorscheme base16-gruvbox-dark-hard
"set background=dark
" True Color Support if it's avaiable in terminal
if has("gui_running")
  set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
endif
set number
set relativenumber
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

"###################
"# PLUGINS CONFIG  #
"###################
" vim-autoformat
noremap <F3> :Autoformat<CR>

" Ale
"let g:ale_lint_on_enter = 0
"let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

" Deoplete
let g:deoplete#enable_at_startup = 1

" Jedi-vim
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
