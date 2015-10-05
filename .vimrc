" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader="\<Space>"

" =========== NeoBundle =============================
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'wincent/Command-T'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'LaTeX-Box-Team/LaTeX-Box'
NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'ervandew/supertab'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'tpope/vim-surround'
NeoBundle 'https://github.com/neilagabriel/vim-geeknote'
NeoBundle 'FredKSchott/CoVim'
NeoBundle 'tpope/vim-unimpaired'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" ================ Git ===============================

nnoremap <Leader>g :Gstatus<CR>

" ================ EasyMotion ========================
" MotionSearch
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" ================ Airline ===========================

set laststatus=2

" ================ Syntastic =========================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on
" ================ Color Scheme =====================

colorscheme solarized

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set nohlsearch      " Noh after search

" =============== Key Bindings ======================

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" =============== Copy/Paste ========================

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" =============== Semi To Colon =====================

nnoremap ; :

" =============== Spell Checking ====================
nnoremap <Leader>sc :setlocal spell! spelllang=en_us<CR>
nnoremap <Leader>l ]s
nnoremap <Leader>h [s
nnoremap <Leader>j z=
nnoremap <Leader>a zg

" =============== Buffers ===========================
" nnoremap <C-l> :bnext<CR>
" nnoremap <C-h> :bprevious<CR>

" ================ Latex =============================

au BufRead,BufNewFile *.txt,*.tex set nowrap wrap linebreak nolist spell textwidth=0 wrapmargin=0

let g:tex_flavor='latex'

" ================ taglist ==========================

let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>
