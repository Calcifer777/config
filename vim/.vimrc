" plugins
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  let need_to_install_plugins = 1
endif

call plug#begin()
Plug 'tpope/vim-sensible'           			          " Default vim behaviors
Plug 'vim-scripts/The-NERD-tree'    			          " Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'				              " status line
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'            			          " Tagbar
Plug 'airblade/vim-gitgutter'       			          " Git
Plug 'tpope/vim-fugitive'       			              " Git
Plug 'ap/vim-buftabline'            			          " vim buffers
Plug 'qpkorr/vim-bufkill'            			          " vim buffers
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	" fzf
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'            			          " brackets
Plug 'vim-pandoc/vim-pandoc'            			      " pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'chriskempson/base16-vim'
Plug 'scrooloose/syntastic'                         " heavy
Plug 'sainnhe/gruvbox-material'
Plug 'vim-scripts/bash-support.vim' 			          " Bash
Plug 'vim-scripts/indentpython.vim'
Plug 'tell-k/vim-autopep8'
Plug 'hashivim/vim-terraform'	    			            " Terraform
call plug#end()

" filetype plugin indent on
" syntax on

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

" refresh state
set updatetime=250

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

" buffer cycling
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>
nnoremap <S-e> :tabNext<CR>
nnoremap <S-q> :tabprevious<CR>


" plugin setups
"NerdTree"
nnoremap <Leader>f :NERDTreeToggle<Enter>
let NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
"syntastic"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args='--ignore=E501'
"Tagbar toggle"
map <leader>t :TagbarToggle<CR>
"pep8"
let g:pep8_ignore="E501,E722"
" terraform "
let g:terraform_align=1
let g:terraform_fmt_on_save=1
" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox_material'
" fzf
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

" interactive terminal
function! s:exec_on_term(lnum1, lnum2)
  " get terminal buffer
  let g:terminal_buffer = get(g:, 'terminal_buffer', -1)
  " open new terminal if it doesn't exist
  if g:terminal_buffer == -1 || !bufexists(g:terminal_buffer)
    terminal
    let g:terminal_buffer = bufnr('')
    wincmd p
  " split a new window if terminal buffer hidden
  elseif bufwinnr(g:terminal_buffer) == -1
    exec 'sbuffer ' . g:terminal_buffer
    wincmd p
  endif
  " join lines with "\<cr>", note the extra "\<cr>" for last line
  " send joined lines to terminal.
  call term_sendkeys(g:terminal_buffer,
        \ join(getline(a:lnum1, a:lnum2), "\<cr>") . "\<cr>")
endfunction

command! -range ExecOnTerm call s:exec_on_term(<line1>, <line2>)
nnoremap <leader>e :ExecOnTerm<cr>
vnoremap <leader>e :ExecOnTerm<cr>

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" color scheme
syntax on
filetype on
filetype plugin indent on
colorscheme gruvbox-material

set guifont=Liberation\ Mono\ for\ Powerline\ 10  " needed for airline

" syntax highlight for hcl files; same a tf files
au BufNewFile,BufRead ?\+.hcl setf tf

" ext setups
setl                         tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
autocmd Filetype py     setl tabstop=4 softtabstop=4 expandtab shiftwidth=4
autocmd Filetype scala  setl tabstop=2 softtabstop=2 expandtab shiftwidth=2
autocmd Filetype md     setl tabstop=2 softtabstop=2 expandtab shiftwidth=2
autocmd FileType json syntax match Comment +\/\/.\+$+

