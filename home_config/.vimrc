"default conf

set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf8

" set the runtime path to include Vundle and initialize {{{
call plug#begin('~/.vim/plugged')
Plug 'VundleVim/Vundle.vim'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-navigator'
Plug 'direnv/direnv'
Plug 'fisadev/vim-isort'
Plug 'flazz/vim-colorschemes'
Plug 'hassek/vim-easytest'
Plug 'jremmen/vim-ripgrep'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/ZoomWin'
Plug 'vim-scripts/tagbar'
Plug 'dense-analysis/ale'
Plug 'python/black'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'adelarsq/vim-matchit'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'christoomey/vim-sort-motion'
" Plug 'christoomey/vim-tmux-runner'
" Plug 'mattn/emmet-vim'
" Plug 'mattn/webapi-vim'
" Plug 'mkitt/tabline.vim'
" Plug 'kana/vim-textobj-user'
" Plug 'michaeljsmith/vim-indent-object'
" Plug 'bps/vim-textobj-python'
" Plug 'rust-lang/rust.vim'
" Initialize plugin system
call plug#end()
" }}}

" base configurations ---- {{{
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"Activate per project .vimrc
" plave a .vimrc on your project wich will add/override any config here
set exrc

set nobackup
set nowritebackup
" set termguicolors
filetype plugin on
set nolist
set nowrap
" set synmaxcol=220
set number
set relativenumber
set backspace=indent,eol,start    " backspace through everything in insert mode
" colorscheme vibrantink
colorscheme BlackSea
" calmbreeze
hi Search cterm=NONE ctermfg=grey ctermbg=yellow
nnoremap <leader>' :nohlsearch<CR>
syntax on

" ctags conf
set tags+=./tags;$HOME

" On pressing tab, insert 4 spaces
set expandtab

" Don't replace content when pasting
xnoremap p pgvy

" switch between panes
nnoremap ]b :tabn<CR>
nnoremap [b :tabp <CR>

" }}}

" vimrc folding setup ---- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Searching ---- {{{

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
hi Search ctermfg=grey
" }}}

" Big files handler ---- {{{
autocmd BufReadPre * if getfsize(expand("%")) > 10000000 | syntax off | endif
" }}}

" Remember cursor postition ---- {{{
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}

" Handy tools for opening files on buffers ---- {{{
" http://vimcasts.org/e/14
nnoremap <leader>ew :e <C-R>=expand('%:h').'/'<cr>
nnoremap <leader>es :sp <C-R>=expand('%:h').'/'<cr>
nnoremap <leader>ev :vsp <C-R>=expand('%:h').'/'<cr>
nnoremap <leader>et :tabe <C-R>=expand('%:h').'/'<cr>


" cd to the directory containing the file in the buffer
nnoremap <silent> <leader>cd :lcd %:h<CR>
" }}}

" Word manipulation ---- {{{
" upper/lower word
nnoremap <leader>u mQviwU`Q
nnoremap <leader>l mQviwu`Q

" upper/lower first char of word
nnoremap <leader>U mQgewvU`Q
nnoremap <leader>L mQgewvu`Q
" }}}

" Git conflicts ---- {{{
" find merge conflict markers
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" see git conflicts on quickfix
nnoremap <leader>gt :Git mergetool<cr>
" }}}

" Python configs --- {{{
set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=999
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=999
au BufRead,BufNewFile *.html set filetype=htmldjango
autocmd FileType htmldjango map <leader>i mmgg=G`m
autocmd FileType htmldjango setlocal commentstring={#\ %s\ #}
autocmd FileType python map <leader>i :Isort<CR> :Black<CR>
let g:black_linelength = 119
autocmd FileType python map <buffer> <C-z> :normal Oimport ipdb; ipdb.set_trace()<Esc>:w<CR>
autocmd FileType python imap <buffer> <C-z> import ipdb; ipdb.set_trace()<Esc>
autocmd FileType python nnoremap <F6> :!ctags -R --exclude=static --python-kinds=-i * && ctags -R --python-kinds=-i -a $VIRTUAL_ENV/lib/python3.8/site-packages/django/*<CR>
" }}}

" Rust configs ---- {{{
autocmd FileType rust map <buffer> <C-z> :normal Odebug_here!();<Esc>:w<CR>
autocmd FileType rust imap <buffer> <C-z> debug_here!();<Esc>
autocmd FileType rust let easytest_rust_syntax = 1
autocmd FileType rust map <leader>i :RustFmt<CR>
" }}}

" vue configuration ---- {{{
autocmd FileType vue setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=999
autocmd FileType javascript.jsx setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=999
" }}}

" set spelling on by default for typical doc files ---- {{{
augroup spellcheck_documentation
    autocmd BufNewFile,BufRead *.md setlocal spell
augroup END
" }}}

" fzf configuration ---- {{{
noremap <leader>hf :Helptags<CR>
noremap <leader>/ :Files<CR>
noremap <leader>b :Buffers<CR>

" let g:fzf_action = {
"   \ '<leader>-f t': 'tab split',
"   \ '<leader>-f s': 'split',
"   \ '<leader>-f v': 'vsplit' }

" }}}

" open/close tagbar
nnoremap \rt :TagbarToggle<CR>

" redraw
nnoremap \r :redraw!<CR>

" airline configuration ---- {{{
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" don't load any extension to make it faster
let g:airline_extensions = ["ale", "fzf", "fugitiveline", "branch"]

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" let g:airline_left_sep='>'
" let g:airline_right_sep='<'
let g:airline_skip_empty_sections = 1
let b:airline_whitespace_disabled = 0
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_detect_spell=1
let g:airline_detect_iminsert=0
let g:airline_inactive_collapse=1

let g:airline#extensions#whitespace#trailing_format = 'tr[%s]'

" airline tabline configuration
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_theme='badwolf'

" airline tmuxline
let g:airline#extensions#tmuxline#enabled = 1
" }}}

" vimgutter colors
highlight SignColumn ctermbg=black

" Fugitive conf ---- {{{
autocmd BufReadPost fugitive://* set bufhidden=delete
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set diffopt+=vertical
" }}}

" RipGrep configuration
" let g:ack_default_options = " -s -H --color --nogroup --column"
map <C-F> :Rg 

" ident the whole file
map <leader>p :set paste<CR><esc>"*]p:set nopaste<cr>

" Ale configs ---- {{{
let g:ale_linters = {
\   'python': ['flake8'],
\   'rust': ['cargo'],
\   'java': [''],
\}
let g:ale_fixers = {'python': ['isort', 'black']}
let g:ale_echo_msg_format = '%linter% says %s'
" let g:ale_python_flake8_executable = $VIRTUALENV . 'bin/flake8'
" let g:ale_python_pylint_executable = $VIRTUALENV . 'bin/pylint'
" let g:ale_python_flake8_args='--ignore=E124,E226,E24,E128,E127,E123,E126,E731 --max-line-length=119'
" let g:ale_python_pylint_args='--py3k'
" }}}

"test mappings per filetype
autocmd FileType ruby map <buffer> <C-z> :normal Irequire 'pry-byebug'; binding.pry<Esc>
autocmd FileType ruby imap <buffer> <C-z> require 'pry-byebug'; binding.pry<Esc>
autocmd FileType go map <buffer> <C-z> :normal runtime.Breakpoint()<Esc>:w<CR>
autocmd FileType go imap <buffer> <C-z> runtime.Breakpoint()<Esc>

" map to auto format json
"map <C-j> :%!python -m json.tool

map <leader>z :normal I{% load dashboard_tpl_tags %} {{CHANGEME\|pdb}}<Esc>
imap <leader>z {% load dashboard_tpl_tags %} {{CHANGEME\|pdb}}
map <leader>s :normal Idebugger;<Esc>
imap <leader>s debugger;
map <C-c> :sp $VIRTUAL_ENV/lib/python3.8/site-packages/<CR>

"let g:vim_json_warnings=0

" TMUX GOODIES
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" faster resize panes
map <leader>k :res +10<CR>
map <leader>j :res -10<CR>
map <leader>l :vertical res +10<CR>
map <leader>h :vertical res -10<CR>


" zoom a vim pane, <C-w>= to re-balance
map <leader><leader> :ZoomWin <CR>
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" VTR settings --- {{{
let g:VtrUseVtrMaps = 0
autocmd FileType python let g:VtrStripLeadingWhitespace = 0
autocmd FileType python let g:VtrClearEmptyLines = 0
autocmd FileType python let g:VtrAppendNewline = 1
" }}}


let g:gundo_prefer_python3 = 1
nnoremap <F3> :GundoToggle<CR>

autocmd FileType go,java nnoremap <F6> :!ctags -R *<CR>
autocmd FileType javascript,vue nnoremap <F6> :!ctags -R --exclude=node_modules --exclude=dist *<CR>

nnoremap <F9> :vsplit $MYVIMRC<CR>
nnoremap <F10> :so $MYVIMRC<CR>

let $JS_CMD='node'
let g:gist_open_browser_after_post = 1

" My plugin config vim-easytest
" autocmd FileType python let easytest_django_nose_syntax = 1
autocmd FileType python let easytest_django_syntax = 1
autocmd FileType ruby let easytest_ruby_syntax = 1
nnoremap <S-t> :py3 run_current_test()<CR>
nnoremap <C-t> :py3 run_current_class()<CR>
" nnoremap <S-F> :py run_current_file()<CR>

" open quickfix if it has data
nnoremap <F2> :cw<CR>

" coc completion configuration ---- {{{
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" airline config with coc
" if you want to disable auto detect, comment out those two lines
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_extensions = ['branch', 'hunks', 'coc']

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
" }}}

" font
set guifont=Menlo:h14

" ---------------Functions---------------  {{{"

augroup ansible-vault
  autocmd!
  autocmd BufReadPre,FileReadPre vault.yml setlocal viminfo=
  autocmd BufReadPre,FileReadPre vault.yml setlocal noswapfile noundofile nobackup
  autocmd BufReadPost,FileReadPost vault.yml silent %!ansible-vault decrypt
  autocmd BufWritePre,FileWritePre vault.yml silent %!ansible-vault encrypt
  autocmd BufWritePost,FileWritePost vault.yml silent undo
augroup END

function! HighlightRepeats() range
    let lineCounts = {}
    let lineNum = a:firstline
    while lineNum <= a:lastline
        let lineText = getline(lineNum)
        if lineText != ""
            let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
        endif
        let lineNum = lineNum + 1
    endwhile
    exe 'syn clear Repeat'
    for lineText in keys(lineCounts)
        if lineCounts[lineText] >= 2
            exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
        endif
    endfor
endfunction

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
autocmd! GUIEnter * set vb t_vb=

set secure
" }}}

" execute retab when saving a file
augroup retabing
  autocmd!
  autocmd FileType python :retab
augroup END

" Development commands
" testing things up
" execute "normal! ?def \r:nohlsearch\rwve"
" execute "%s/\t/&tabstop<space>
" :%s/\t/\=execute("norm!" . expand(&tabstop) . " i"/g
