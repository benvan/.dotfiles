filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

"let g:tex_flavor='latex'

"command W w !sudo tee % > /dev/null

" Window movements
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set nocompatible
set t_Co=256
syntax on
let g:molokai_original = 0
colorscheme molokai
set modelines=0
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
set undofile

let mapleader = ","

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <tab> %
vnoremap <tab> %

set wrap
set paste
"set textwidth=79
set formatoptions=qrn1

set list
"set listchars=tab:▸\ 

" USE THE GODDAMN HJKL KEYS!
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" turn off help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"nnoremap ; :

au FocusLost * :wa

" leader maps
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>v V`]
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader><space> :noh<cr>
" insert one character
nnoremap <space> i<Space><Esc>r
nnoremap <silent><leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" NERD Tree
map <F2> :NERDTreeToggle<cr>
map <F3> :NERDTreeFind<cr>

inoremap jj <ESC>


nnoremap gb :bn<cr>
nnoremap gB :bp<cr>


" VIM FOR RAILS STUFF ...
" Add recently accessed projects menu (project plugin)
set viminfo^=!

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
set cf
set clipboard+=unnamed
set autowrite
set timeoutlen=1000

set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent

" COMMANT-T PLUGIN SETTINGS
let g:CommandTAcceptSelectionVSplitMap=['<C-CR>']
let g:CommandTCancelMap=['<ESC>']

set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" Backups & Files
set backup                     " Enable creation of backup file.
set backupdir=~/.vim/backups " Where backups will go.
set directory=~/.vim/tmp     " Where temporary files will go.
set undodir=~/.vim/tmp

au BufNewFile,BufRead *.sbt setf scala


