" Referenced used
" https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim

set sessionoptions+=globals
let mapleader = ","

" # Plugins

call plug#begin(expand('~/.vim/plugged'))
Plug 'dense-analysis/ale'

" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" https://liquidz.github.io/vim-iced/
Plug 'ctrlpvim/ctrlp.vim', {'for': 'clojure'}

" Requires
Plug 'guns/vim-sexp',    {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}

" https://github.com/fatih/vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" https://vimawesome.com/plugin/vim-javascript
Plug 'pangloss/vim-javascript'

" https://github.com/MaxMEllon/vim-jsx-pretty
Plug 'maxmellon/vim-jsx-pretty'

" https://github.com/leafgarland/typescript-vim
Plug 'leafgarland/typescript-vim'

" https://www.nordtheme.com/docs/ports/vim/
Plug 'arcticicestudio/nord-vim'

" https://vimawesome.com/plugin/nimrod-vim
Plug 'zah/nim.vim'

" https://vimawesome.com/plugin/zig-vim
Plug 'zig-lang/zig.vim'

call plug#end()

" # Helper Functions
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! SetCommentChar(char)
    execute 'nnoremap ? I' . a:char . ' <TAB><ESC>'
    execute 'nnoremap <leader>? 0ce <ESC>'
    execute 'vnoremap ? :normal 0i' . a:char . '  <CR>'
    execute 'vnoremap <leader>? :normal 03x<CR>'
endfunction
 
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

" Set column width (80)
set textwidth=80

" Find files
set path+=**

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,.*
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set number
set relativenumber
set ruler

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes


" Add a bit extra margin to the left
"set foldcolumn=1

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags .


" # Navigation
"
" indent/unindent with tab/shift-tab
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv

" Comment Line(s)
call SetCommentChar('#')

" # Fonts and Colors


" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,mac,dos

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

" Line width column marker (default 80)
set colorcolumn=80

" ## Nord Theme
"
" Enable cursor background color highlighting
"set cursorline
let g:nord_cursor_line_number_background = 0
let g:nord_uniform_status_lines = 1

" Enable nord colors
colorscheme nord


" # Visual mode related

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

vmap <leader>( xi()<Esc>P
vmap <leader>[ xi[]<Esc>P
vmap <leader>{ xi{}<Esc>P
vmap <leader>" xi""<Esc>P
vmap <leader>' xi''<Esc>P
vmap <leader>< xi<><Esc>P

" # Spell checking

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" # Language Configuration

" ## Ale settings
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_lint_on_insert_leave = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_hover_cursor = 1
let g:ale_lsp_suggestions = 1
let g:ale_rust_cargo_use_check = 1
let g:ale_virtualtext_cursor = 1
nnoremap <C-.> <Plug>(ale_hover)
nnoremap <C-O> <Plug>(ale_import)

" Linters
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'python': ['pylint', 'mypy'],
\  'rust': ['analyzer'],
\}

let g:ale_fixers = { 
\  'javascript': ['eslint'],
\  'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']
\}

" Clojure
autocmd BufNewFile,BufRead *.clj set filetype=clojure
autocmd BufRead,BufNewFile *.clj call SetCommentChar('//')
augroup clojure
" Iced Keybindings
let g:iced_enable_default_key_mappings = v:true
augroup END

" Enable language specific filetypes
" Javascript
autocmd BufRead,BufNewFile *.js call SetCommentChar('//')

" Typescript
autocmd BufNewFile,BufRead *.ts set filetype=typescript
augroup typescript 
    au BufRead,BufNewFile *.ts setlocal formatprg=prettier\ --parser\ typescript
    au BufRead,BufNewFile *.ts call SetCommentChar('//')
augroup END

" Yaml
autocmd BufNewFile,BufRead *.yaml set filetype=yaml
autocmd BufNewFile,BufRead *.yml set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
augroup yaml

set foldlevelstart=20

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
augroup END

" Go
autocmd BufRead,BufNewFile *.go call SetCommentChar('//')
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Rust
autocmd BufNewFile,BufRead *.rs set filetype=rust
augroup filetype_rust
    au!
    au BufRead,BufNewFile *.rs nnoremap K :ALEHover<CR>
    au BufRead,BufNewFile *.rs nnoremap <C-]> :ALEGoToDefinition<CR>
    au BufRead,BufNewFile *.rs call SetCommentChar('//')
augroup END

" Python Ale configurations
let g:ale_python_pylint_options = '--load-plugins pylint_django'

" Lisp
let g:slimv_repl_split = 4

" Vim or ~/.vimrc
autocmd BufNewFile,BufRead *.vim,.vimrc set filetype=vim
augroup vim
    call SetCommentChar('"')
augroup END

