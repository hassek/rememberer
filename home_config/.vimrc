"default conf

set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=utf8

" set the runtime path to include Vundle and initialize {{{
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-navigator'
Plug 'direnv/direnv'
Plug 'fisadev/vim-isort'
Plug 'flazz/vim-colorschemes'
" Plug 'hassek/vim-easytest'
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
Plug 'psf/black', { 'branch': 'stable' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'adelarsq/vim-matchit'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lepture/vim-velocity'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'darrikonn/vim-gofmt', { 'do': ':GoUpdateBinaries' }
" java formatter
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Java autocomplete
Plug 'artur-shaik/vim-javacomplete2'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'
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

call glaive#Install()
" " Optional: Enable codefmt's default mappings on the <Leader>= prefix.
" Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="/opt/homebrew/Cellar/openjdk@17/17.0.5/bin/java -jar /Users/tomas.henriquez/.vim/google-java-format-1.15.0-all-deps.jar"
autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)

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

" augroup autoformat_settings
" autocmd FileType java AutoFormatBuffer google-java-format
" augroup END

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

autocmd FileType * map <leader>i :ALEFix<CR>
" autocmd FileType java map <leader>i :FormatCode<CR>
" autocmd FileType go map <leader>i :GoFmt<CR> :GoImports<CR>

" Python configs --- {{{
set tabstop=2 softtabstop=2 shiftwidth=2 textwidth=999
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=999
au BufRead,BufNewFile *.html set filetype=htmldjango
autocmd FileType htmldjango map <leader>i mmgg=G`m
autocmd FileType htmldjango setlocal commentstring={#\ %s\ #}
" autocmd FileType python map <leader>i :Isort<CR> :Black<CR>
autocmd FileType python setlocal makeprg=ruff\ check\ .
autocmd FileType python map <leader>f :!ruff % --fix<CR>
" autocmd FileType python let b:dispatch = 'pylint -f parseable %'
let g:black_linelength = 119
autocmd FileType python map <buffer> <C-z> :normal Oimport ipdb; ipdb.set_trace()<Esc>:w<CR>
autocmd FileType python imap <buffer> <C-z> import ipdb; ipdb.set_trace()<Esc>
autocmd FileType python nnoremap <F6> :!ctags -R --exclude=statics --exclude='*.sql' --python-kinds=-i ./*<CR>
" }}}

let g:dispatch_handlers = ['tmux']
let g:dispatch_tmux_pipe_pane = 1
" Rust configs ---- {{{
autocmd FileType rust map <buffer> <C-z> :normal Odebug_here!();<Esc>:w<CR>
autocmd FileType rust imap <buffer> <C-z> debug_here!();<Esc>
autocmd FileType rust let easytest_rust_syntax = 1
autocmd FileType rust map <leader>i :RustFmt<CR>
" }}}

" vue configuration ---- {{{
autocmd FileType vue setlocal tabstop=2 softtabstop=2 shiftwidth=2 textwidth=999
autocmd FileType javascript.jsx setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=999
" }}}

let g:coc_node_path = '/Users/tomas.henriquez/.nvm/versions/node/v18.12.0/bin/node'

" java configuraiton
" autocmd FileType java setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*//'
augroup filetype_java
    autocmd!
    let b:codefmt_auto_format_buffer=0
    autocmd FileType java :set fmr=/**,*/ fdm=marker fdc=1
augroup END

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
" To deactivate java linter
let g:ale_java_checkstyle_config="~/checkstyle-checker.xml"
let g:ale_linters = {
\   'python': ['ruff'],
\   'rust': ['cargo'],
\   'go': ['gopls', 'staticcheck', 'govet'],
\   'java': ['checkstyle', 'javac'],
\   'javascript': ['eslint'],
\}
let g:ale_go_staticcheck_lint_package=1
let g:ale_fixers = {
\  'python': ['isort', 'black', 'ruff'],
\  'go': ['gofmt', 'goimports'],
\  'javascript': ['prettier'],
\  'vue': ['prettier'],
\}
let g:ale_echo_msg_format = '%linter% says %s'
" let g:ale_completion_enabled=1

" }}}

"test mappings per filetype
autocmd FileType ruby map <buffer> <C-z> :normal Irequire 'pry-byebug'; binding.pry<Esc>
autocmd FileType ruby imap <buffer> <C-z> require 'pry-byebug'; binding.pry<Esc>
autocmd FileType go map <buffer> <C-z> :normal runtime.Breakpoint()<Esc>:w<CR>
autocmd FileType go imap <buffer> <C-z> runtime.Breakpoint()<Esc>
autocmd FileType go :set fmr=/**,*/ fdm=marker fdc=1

" map to auto format json
"map <C-j> :%!python -m json.tool

map <leader>z :normal I{% load dashboard_tpl_tags %} {{CHANGEME\|pdb}}<Esc>
imap <leader>z {% load dashboard_tpl_tags %} {{CHANGEME\|pdb}}
map <leader>s :normal Idebugger;<Esc>
imap <leader>s debugger;
map <C-c> :sp $VIRTUAL_ENV/lib/python3.12/site-packages/<CR>

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
let g:vim_isort_python_version = 'python3'
nnoremap <F3> :GundoToggle<CR>
let g:black_use_virtualenv = 0

nnoremap <F6> :!ctags -R --exclude=node_modules --exclude=dist --exclude=static *<CR>

nnoremap <F9> :vsplit $MYVIMRC<CR>
nnoremap <F10> :so $MYVIMRC<CR>

let $JS_CMD='node'
let g:gist_open_browser_after_post = 1

" My plugin config vim-easytest
" autocmd FileType python let easytest_django_nose_syntax = 1
autocmd FileType python let easytest_django_syntax = 1
autocmd FileType ruby let easytest_ruby_syntax = 1
autocmd FileType go let easytest_go_syntax = 1
nnoremap <S-t> :py3 run_current_test_on_terminal()<CR>
nnoremap <C-t> :py3 run_current_class_on_terminal()<CR>
" nnoremap <S-F> :py run_current_file()<CR>

" open quickfix if it has data
nnoremap <F2> :cw<CR>

" coc completion configuration ---- {{{

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

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
