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
call plug#begin()

" Theme
Plug 'NLKNguyen/papercolor-theme'

" UI stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Linter, formatter and Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" AutoPairs
Plug 'jiangmiao/auto-pairs'

" Nerd icons
Plug 'ryanoasis/vim-devicons'

" Snippets
Plug 'honza/vim-snippets'

" File navigation -> ranger + Nerd Tree
Plug 'preservim/nerdtree'

call plug#end()

