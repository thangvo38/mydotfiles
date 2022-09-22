" ================ General Config ==================== "

" Do not use vim compatibility settings
set nocompatible

" Disable typefile detection and turn on plugin indent
filetype off
filetype plugin indent on

" Automatically install VimPlug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Move swp files away from your project directory
if !isdirectory("~/.vimswap")
  silent execute '!mkdir -p ~/.vimswap'
endif

set directory=~/.vimswap/

" Reduce keycode delay when pressing Esc from Insert mode
set timeoutlen=500
set ttimeout        " time out for key codes
set ttimeoutlen=0 " wait up to 0ms after Esc for special key

" Store more history
set history=1000

"Allow backspacing over everything in insert mode
set backspace=indent,eol,start 

" Show ruler, number, cmd, etc..
set ruler
set number
set showcmd
set incsearch
set hlsearch

" Turn on syntax highlighting
syntax on
syntax enable

" Turn on mouse support
set mouse=a

" ================ Plugin Installation ==================== "
call plug#begin('~/.vim/plugged')

" Find files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Linter
Plug 'alvan/vim-closetag'
Plug 'mlaursen/vim-react-snippets'
Plug 'mlaursen/rmd-vim-snippets'

" Language support
Plug 'sheerun/vim-polyglot'

" React highlight
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Rust support
Plug 'rust-lang/rust.vim'

" Theme
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sickill/vim-monokai'
Plug 'dracula/vim', { 'as': 'dracula' }

" Browsing files
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

" Utilities
Plug 'xolox/vim-misc'

" File taging
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'

" Other text editing features
Plug 'Raimondi/delimitMate'

" Syntax plugins
Plug 'vim-syntastic/syntastic'
Plug 'jez/vim-c0'
Plug 'jez/vim-ispc'
Plug 'kchmck/vim-coffee-script'
Plug 'Yggdroot/indentLine'

" cocnvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" ================ Plugin Settings ==================== "
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_gui = '#292928'

" vim-airline settings
" Always show statusbar
set laststatus=2

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Use the solarized theme for the Airline status bar
let g:airline_theme='dracula'

" Use theme
"let g:vim_monokai_tasty_italic = 1
colorscheme monokai

" scrooloose/syntastic settings
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" xolox/vim-easytags settings
" Where to look for tags files
set tags=./tags;,~/.vimtags

" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1


" airblade/vim-gitgutter settings
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" Raimondi/delimitMate settings
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" NERDTree
" Automatically open NERDtree when opening new tab
autocmd BufWinEnter * NERDTreeMirror

" To have NERDTree always open on startup (0 = disable, 1 = enable)
let g:nerdtree_tabs_open_on_console_startup = 0
let NERDTreeShowHidden=1

" We need this for plugins like Syntastic and vim-gitgutter which put symbols
" in the sign column.
hi clear SignColumn

" ================ Indentation ==================== "
" Default indent for all file types
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab

" Set indent based on file types
" " Tab space=4
autocmd FileType python setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd FileType rust setlocal tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" " Tab space=2
autocmd FileType proto setlocal tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd FileType bash setlocal tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd FileType sh setlocal tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd FileType javascript setlocal tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab

" ================ Key Remapping  ==================== "
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>

" No auto insert mode when typing
nn a <nop>
nn o <nop>
nn s <nop>

" Delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Replace currently selected text with default register without yanking it
vnoremap <leader>p "_dP

" Toggle PASTE mode to turn off autoindent when pasting in insert mode
set pastetoggle=<F3>

" Toogle FZF with \f
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>

" Toogle silver searcher with \g
nnoremap <silent> <leader>g :Ag<cr>
nnoremap <silent> <leader>G :Ag ~<cr>

" NERDtree toogle with F6
nmap <silent> <F6> :NERDTreeToggle<CR>
" Refresh current file and go to file in NERDTree with F5
nmap <silent> <F5> :NERDTreeFind<CR>:NERDTreeFocus<cr> \| R \| <c-w><c-p>

" Copy selected text to clipboard with \y
noremap <Leader>y "+y
noremap <Leader>Y "+y

command! What echo synIDattr(synID(line('.'), col('.'), 1), 'name')

" ================ Language support ==================== "
" Rust
" Auto run rustfmt on save
let g:rustfmt_autosave = 1

" Javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Markdown
let g:vim_markdown_folding_disabled = 1

" Folding
"set foldmethod=indent
set foldmethod=syntax
set foldlevel=1
set foldclose=all

" ================ Others ==================== "
" The output of :ls is sorted by buffer number.
" Define command :Ls is the same as the output of :ls except that the output is sorted by buffer name.
" See https://vim.fandom.com/wiki/List_buffers_sorted_by_name
command! -bang Ls redir @" | silent ls<bang> | redir END | echo " " |
 \ perl {
 \ my $msg=VIM::Eval('@"');
 \ my %list=();
 \ my $key, $value;
 \ while($msg =~ m/(.*?line\s+\d+)/g)
 \ {
 \ $value = $1;
 \ $value =~ m/"([^"]+)"/;
 \ $key = $1;
 \ ($^O =~ /mswin/i) and $key = lc($key);
 \ $list{$key} = $value;
 \ }
 \ my $msg = '';
 \ for $key (sort keys %list)
 \ {
 \ $msg .= "$list{$key}\n";
 \ }
 \ VIM::Msg($msg);
 \ }
 \ <CR>

