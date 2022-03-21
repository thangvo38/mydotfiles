" Must be at the beginning of file
set nocompatible
filetype off

" --- Disable polyglot Rust support
let g:polyglot_disabled = ['rust']

" ---- Swap files begone!!! ---- "
set directory^=$HOME/.vim/tmp//

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" ---- Find files
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" ==================================
" " Linters, validators, and autocomplete
" " ==================================
Plugin 'alvan/vim-closetag'
Plugin 'mlaursen/vim-react-snippets'
Plugin 'mlaursen/rmd-vim-snippets'

" ---- Language support
Plugin 'sheerun/vim-polyglot'

" ---- React highlight
Plugin 'yuezk/vim-js'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'maxmellon/vim-jsx-pretty'

" ---- Rust support
Plugin 'rust-lang/rust.vim'

" ---- Markdown
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'

" ----- Making Vim look good ------------------------------------------
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" ----- Vim as a programmer's text editor -----------------------------
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-syntastic/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-scripts/a.vim'

" ----- Working with Git ----------------------------------------------
Plugin 'airblade/vim-gitgutter'

" ----- Other text editing features -----------------------------------
Plugin 'Raimondi/delimitMate'

" ----- man pages, tmux -----------------------------------------------
Plugin 'jez/vim-superman'
Plugin 'christoomey/vim-tmux-navigator'

" ----- Syntax plugins ------------------------------------------------
Plugin 'jez/vim-c0'
Plugin 'jez/vim-ispc'
Plugin 'kchmck/vim-coffee-script'

Plugin 'Yggdroot/indentLine'

" ----- Theme ---------------------------------------------------------
Plugin 'dracula/vim', { 'name': 'dracula' }

call vundle#end()

filetype plugin indent on

" --- General settings ---
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

syntax on
syntax enable

set mouse=a

" We need this for plugins like Syntastic and vim-gitgutter which put symbols
" in the sign column.
hi clear SignColumn

" Allow backspacing over everything in insert mode 
set backspace=indent,eol,start

" ----- Plugin-epecifi ---------
let g:indentLine_defaultGroup = 'SpecialKey'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#292928'

" ----- altercation/vim-colors-solarized settings -----
" Toggle this to "light" for light colorscheme
set background=dark

" ----- bling/vim-airline settings -----
" Always show statusbar
set laststatus=2

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1

" Use the solarized theme for the Airline status bar
let g:airline_theme='solarized'
colorscheme dracula

" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" ----- xolox/vim-easytags settings -----
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" ----- majutsushi/tagbar settings -----
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
"autocmd BufEnter * nested :call tagbar#autoopen(0)

" ----- airblade/vim-gitgutter settings -----
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1

" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" ----- NERDTree -----
" NERDtree toogle
nmap <silent> <F6> :NERDTreeToggle<CR>

" Open current file and refresh NERDTRee
nmap <silent> <F5> :NERDTreeFind<CR>:NERDTreeFocus<CR>R<c-w><c-p>

" Automatically open NERDtree when opening new tab
autocmd BufWinEnter * NERDTreeMirror

" Open/close NERDTree Tabs with \t
" nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 1

let NERDTreeShowHidden=1

" No auto insert mode when typing
nn a <nop>
nn o <nop>
nn s <nop>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" " replace currently selected text with default register
" " without yanking it
vnoremap <leader>p "_dP

" Set indent based on file types
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType proto setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab smarttab

" Default indent for all file types
"set tabstop=2
"set shiftwidth=2
"set softtabstop=2
"set expandtab
"set smarttab

" Toggle PASTE mode to turn off autoindent when pasting in insert mode
set pastetoggle=<F3>

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

" ----- Javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" ----- FZF
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>F :FZF ~<cr>

" ----- Reduce keycode delay when pressing Esc from Insert mode
set timeoutlen=100
set ttimeout        " time out for key codes
set ttimeoutlen=0 " wait up to 0ms after Esc for special key

" ---- Markdown
let g:vim_markdown_folding_disabled = 1

