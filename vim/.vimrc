" plugins
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  let need_to_install_plugins = 1
endif

call plug#begin()
Plug 'tpope/vim-sensible'           " Default vim behaviors
Plug 'vim-scripts/The-NERD-tree'    " Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'            " Tagbar
Plug 'airblade/vim-gitgutter'       " Git
Plug 'ap/vim-buftabline'            " vim buffers
Plug 'scrooloose/syntastic'
Plug 'vim-scripts/bash-support.vim' " Bash
Plug 'davidhalter/jedi-vim'         " Python
Plug 'vim-scripts/indentpython.vim'
call plug#end()

filetype plugin indent on
syntax on

if need_to_install_plugins == 1
  echo "Installing plugins..."
  silent! PlugInstall
  echo "Done!"
  q
endif


" enable 256 colors
set background=dark
set t_Co=256
set t_ut=   " this value is blank intentionally

" turn on line numbering
set number

" sane text files
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

" color scheme
syntax on
colorscheme atom-dark
filetype on
filetype plugin indent on



