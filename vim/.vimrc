" plugins
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  let need_to_install_plugins = 1
endif

call plug#begin()
Plug 'tpope/vim-sensible'           			" Default vim behaviors
Plug 'vim-scripts/The-NERD-tree'    			" Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'				" status line
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'            			" Tagbar
Plug 'airblade/vim-gitgutter'       			" Git
Plug 'ap/vim-buftabline'            			" vim buffers
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	" fzf
Plug 'scrooloose/syntastic'
Plug 'chriskempson/base16-vim'				" colors
Plug 'vim-scripts/bash-support.vim' 			" Bash
Plug 'davidhalter/jedi-vim'         			" Python
Plug 'vim-scripts/indentpython.vim'
Plug 'tell-k/vim-autopep8'
Plug 'hashivim/vim-terraform'	    			" Terraform
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

" wrapping
set nowrap

" sane text files
set fileformat=unix
set encoding=utf-8
set fileencoding=utf-8

" sane editing
" indent/unindent with tab/shift-tab
nmap <Tab> >>
imap <S-Tab> <Esc><<i
nmap <S-tab> <<

" color scheme
syntax on
filetype on
filetype plugin indent on
colorscheme elflord
highlight Visual cterm=reverse ctermbg=NONE

" ext setups
setl tabstop=2 softtabstop=2 expandtab shiftwidth=2 
autocmd Filetype py setl tabstop=4 softtabstop=4 expandtab shiftwidth=4 
autocmd Filetype scala setl tabstop=2 softtabstop=2 expandtab shiftwidth=2 

" plugin setups
"NerdTree"
nnoremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
"NerdTree gitplugin"
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "m",
    \ "Staged"    : "s",
    \ "Untracked" : "u",
    \ "Renamed"   : "r",
    \ "Unmerged"  : "nm",
    \ "Deleted"   : "d",
    \ "Dirty"     : "D",
    \ "Clean"     : "c",
    \ 'Ignored'   : 'i',
    \ "Unknown"   : "?"
    \ }
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
"syntastic"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args='--ignore=E501'
"Tagbar toggle"
map <leader>t :TagbarToggle<CR>
"pep8
let g:pep8_ignore="E501,E722"
" terraform "
let g:terraform_align=1
let g:terraform_fmt_on_save=1
" Airline
let g:airline_powerline_fonts = 1

