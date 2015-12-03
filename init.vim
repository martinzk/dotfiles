let mapleader="\<Space>"

" My plugins
call plug#begin()
Plug 'benekastah/neomake'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
Plug 'sheerun/vim-polyglot'
"Plug 'airblade/vim-rooter'
Plug 'Shougo/unite.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'kassio/neoterm'
call plug#end()

if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" Toggle neomake open list
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 0

function! OpenNeomakeOutput(...)
	if g:neomake_open_list == 0
		:let g:neomake_open_list = 1
		:w
	else
		:let g:neomake_open_list = 0
	endif
endfunction

nnoremap <Leader>t :call OpenNeomakeOutput()<CR>
nnoremap <Leader>m :Neomake!<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" FZF
nnoremap <Space>f :Files<CR>
nnoremap <Space>b :Buffers<CR>
nnoremap <Space>l :Lines<CR>

" ================ Git ===============================
nnoremap <Leader>g :Gstatus<CR>

" General
set visualbell                  "No sounds

" ================ Color Scheme =====================
set background=dark
colorscheme solarized

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

" =============== Navigation ========================
nmap j gj
nmap k gk

" Latex
let g:tex_flavor='latex'

" Turn on numbering and relativenumber
"set number " Can be toggled with unimpaired's 'con'
set relativenumber " Can be toggled with unimpaired's 'cor'

" Automatically scroll when I reach within 3 lines towards end of screen
set sidescrolloff=3
set scrolloff=3

" No backups
set nobackup
set noswapfile
set nowb


set shiftwidth=2
set softtabstop=2
set tabstop=2
set smartindent
set smarttab
set expandtab

set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set nohlsearch      " Noh after search
