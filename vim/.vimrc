" plugins
let need_to_install_plugins = 0
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  let need_to_install_plugins = 1
endif

call plug#begin()
Plug 'tpope/vim-sensible'           			                " Default vim behaviors
Plug 'tpope/vim-unimpaired'
Plug 'dkprice/vim-easygrep'
Plug 'vim-scripts/The-NERD-tree'    			                " Nerdtree
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'				                    " status line
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'            			                " Tagbar
Plug 'airblade/vim-gitgutter'       			                " Git
Plug 'tpope/vim-fugitive'       			                    " Git
Plug 'ap/vim-buftabline'            			                " vim buffers
Plug 'qpkorr/vim-bufkill'            			                " vim buffers
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	      " fzf
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'            			                " brackets
Plug 'vim-pandoc/vim-pandoc'            			            " pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'chriskempson/base16-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'vim-scripts/bash-support.vim' 			                " Bash
Plug 'vim-scripts/indentpython.vim'
Plug 'tell-k/vim-autopep8'
Plug 'aserebryakov/vim-todo-lists'
Plug 'fatih/vim-go'                                       " go
Plug 'jstemmer/gotags'                                    " go
Plug 'derekwyatt/vim-scala'                               " scala
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'neoclide/coc-vimtex', {'tag': '1.0.4'}
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

" search options
set ignorecase
set smartcase

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
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_yaml_checkers = ['jsyaml']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_mode_map = {
          \ "mode": "passive",
          \ "active_filetypes": [],
          \ "passive_filetypes": [] }


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
" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"

" gruvbox-material
" prevents comments from appearing always highlighted
let g:gruvbox_material_disable_italic_comment = 1
" easygrep
let g:EasyGrepRecursive = 1
let g:EasyGrepIgnoreCase = 1
" go
" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

" coc
autocmd FileType json syntax match Comment +\/\/.\+$+
" coc scala
set hidden
" Some servers have issues with backup files
set nobackup
set nowritebackup
" You will have a bad experience with diagnostic messages with the default 4000.
set updatetime=300
" Don't give |ins-completion-menu| messages.
set shortmess+=c
" Always show signcolumns
set signcolumn=yes
" Help Vim recognize *.sbt and *.sc as Scala files
au BufRead,BufNewFile *.sbt,*.sc set filetype=scala
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Used to expand decorations in worksheets
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Remap for do codeAction of current line
xmap <leader>a  <Plug>(coc-codeaction-line)
nmap <leader>a  <Plug>(coc-codeaction-line)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Trigger for code actions
" Make sure `"codeLens.enable": true` is set in your coc config
nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>

" for scala worksheets in nvim
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

"
" " interactive terminal
" function! s:exec_on_term(lnum1, lnum2)
"   " get terminal buffer
"   let g:terminal_buffer = get(g:, 'terminal_buffer', -1)
"   " open new terminal if it doesn't exist
"   if g:terminal_buffer == -1 || !bufexists(g:terminal_buffer)
"     terminal
"     let g:terminal_buffer = bufnr('')
"     wincmd p
"   " split a new window if terminal buffer hidden
"   elseif bufwinnr(g:terminal_buffer) == -1
"     exec 'sbuffer ' . g:terminal_buffer
"     wincmd p
"   endif
"   " join lines with "\<cr>", note the extra "\<cr>" for last line
"   " send joined lines to terminal.
"   call term_sendkeys(g:terminal_buffer,
"         \ join(getline(a:lnum1, a:lnum2), "\<cr>") . "\<cr>")
" endfunction
"
" command! -range ExecOnTerm call s:exec_on_term(<line1>, <line2>)
" nnoremap <leader>e :ExecOnTerm<cr>
" vnoremap <leader>e :ExecOnTerm<cr>

command Sqlfmt execute ":%!sqlformat --reindent --keywords upper --identifiers lower -"
command JsonPrettify execute ":%!python -m json.tool"
command HclFmt execute ":!terragrunt hclfmt --terragrunt-hclfmt-file %"
command HclFmtAll execute ":!terragrunt hclfmt"

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" set guifont=Liberation\ Mono\ for\ Powerline\ 10  " needed for airline
" set guifont=Fira\ Mono\ for\ Powerline\ 10  " needed for airline
set guifont=Ubuntu\ Nerd\ Font\ Complete\ Mono\ Windows\ Compatible\ 10  " needed for airline

" syntax highlight for hcl files; same a tf files
au BufNewFile,BufRead ?\+.hcl setf tf

" syntax highlight for Jenkinsfile
au BufNewFile,BufRead Jenkinsfile setf groovy

" ext setups
set                          tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
autocmd Filetype py     setl tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab
autocmd Filetype scala  setl tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
autocmd Filetype md     setl tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
autocmd Filetype sh     setl tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
autocmd FileType json syntax match Comment +\/\/.\+$+

" vimtex
let g:tex_flavor = 'latex'

" color scheme
syntax on
filetype on
filetype plugin indent on
colorscheme gruvbox-material

