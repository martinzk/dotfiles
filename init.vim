let mapleader="\<Space>"

" My plugins
call plug#begin()
Plug 'benekastah/neomake'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe'
Plug 'sheerun/vim-polyglot'
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

function! NeoFunc(...)
  silent :let g:neomake_open_list = 0
  :Neomake
endfunction
  

" Toggle neomake open list
autocmd! BufWritePost * call NeoFunc()
let g:neomake_open_list = 0

nnoremap <Leader>nt :let g:neomake_open_list = 1<CR>:Neomake<CR>
nnoremap <Leader>nm :let g:neomake_open_list = 1<CR>:Neomake!<CR>
nnoremap <Leader>m  :T make<CR>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" FZF
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>fh :History<CR>
nnoremap <Leader>fa :Ag<CR>

" ======= quickly close buffers
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader>bj <C-w>j:bd<CR>
nnoremap <Leader>bl <C-w>l:bd<CR>
nnoremap <Leader>bk <C-w>k:bd<CR>
nnoremap <Leader>bh <C-w>h:bd<CR>
nnoremap <Leader>bt :call neoterm#close()<CR>

" ====== Undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" ================ Git ===============================
nnoremap <Leader>gs :T gs<CR>
nnoremap <Leader>gpl :T gpl<CR>
nnoremap <Leader>gps :T gps<CR>
nnoremap <Leader>gb :T git blame %<CR>
nnoremap <Leader>ga :T git add %<CR>
nnoremap <Leader>gd :T git diff %<CR>
nnoremap <Leader>gc :T git commit % -m "

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
"nmap j gj
"nmap k gk

" Latex
let g:tex_flavor='latex'

set number " Can be toggled with unimpaired's 'con'
" turn on relative numbers on everything but latex

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

" ===== Fuzzy search contents directory
function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  let first = list[0]
  execute cmd escape(first.filename, ' %#\')
  execute first.lnum
  execute 'normal!' first.col.'|zz'

  if len(list) > 1
    call setqflist(list)
    copen
    wincmd p
  endif
endfunction

command! -nargs=* Ag call fzf#run({
\ 'source':  printf('ag --nogroup --column --color "%s"',
\                   escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\ 'sink*':    function('<sid>ag_handler'),
\ 'options': '--ansi --expect=ctrl-t,ctrl-v,ctrl-x --delimiter : --nth 4.. '.
\            '--multi --bind ctrl-a:select-all,ctrl-d:deselect-all '.
\            '--color hl:68,hl+:110',
\ 'down':    '50%'
\ })
" ===== Fuzzy search contents directory END
