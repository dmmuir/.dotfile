" Referenced used
" https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim

let mapleader = ","

" # Plugins

call plug#begin(expand('~/.vim/plugged'))
Plug 'dense-analysis/ale'

" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" https://www.nordtheme.com/docs/ports/vim/
Plug 'arcticicestudio/nord-vim'

" https://vimawesome.com/plugin/nimrod-vim
Plug 'zah/nim.vim'


" https://vimawesome.com/plugin/rust-vim-superman
Plug 'rust-lang/rust.vim'

" https://vimawesome.com/plugin/zig-vim
Plug 'zig-lang/zig.vim'

call plug#end()


" # General

" Enable filetype plugins
filetype on
filetype indent on
filetype plugin on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" :W sudo saves the file
" (useful for handling the permission-denied error)
"command! W execute 'w !sudo tee % > /dev/null' <bar> edit!


" # Vim Interface " Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Set column width
"set columns=80
set textwidth=80

" Find files
set path+=**

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set number
set relativenumber
set ruler

" Add a bit extra margin to the left
"set foldcolumn=1

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .


" # Navigation
"
" indent/unindent with tab/shift-tab
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv

" # Fonts and Colors


" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" # Files, backups and undo

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" # Text, tab and indent related

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" ## Nord Theme
"
" Enable cursor background color highlighting
set cursorline
let g:nord_cursor_line_number_background = 0
let g:nord_uniform_status_lines = 1

" Enable nord colors
colorscheme nord


" # Visual mode related

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" # Spell checking

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
