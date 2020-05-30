" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"###########
"# PLUGINS #
"###########
"VIM PLUG
"https://github.com/junegunn/vim-plug
call plug#begin()

" Theme
Plug 'NLKNguyen/papercolor-theme'

" UI stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Better Visual Guide
Plug 'Yggdroot/indentLine'

" Syntax highlighting
"Plug 'sheerun/vim-polyglot'

" Linter, formatter and Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" AutoPairs
Plug 'jiangmiao/auto-pairs'

" Code folding
"Plug 'tmhedberg/SimpylFold'

" Nerd icons
Plug 'ryanoasis/vim-devicons'

" Snippets
Plug 'honza/vim-snippets'

" File navigation -> ranger + Nerd Tree
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'preservim/nerdtree'

" Which Key -> display available keybindings in popup
Plug 'liuchengxu/vim-which-key'

" FZF -> fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
call plug#end()

