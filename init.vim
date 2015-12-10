let mapleader="\<Space>"

" My plugins
call plug#begin()
Plug 'benekastah/neomake'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/unite.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'kassio/neoterm'

" closing
Plug 'cohama/lexima.vim'
" commenting
Plug 'tpope/vim-commentary'
" CamelCase word motions
Plug 'bkad/CamelCaseMotion'
" Asynchronous completion
Plug 'Shougo/deoplete.nvim'
" Buffers instead of tabs
Plug 'ap/vim-buftabline'

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
nnoremap <Leader>m :T make<CR>

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

nnoremap <M-n> :bnext<CR>
nnoremap <M-p> :bprevious<CR>

" ====== Undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" ================ Git ===============================
nnoremap <Leader>gs :T gs<CR>
nnoremap <Leader>gpl :T gpl<CR>
nnoremap <Leader>gps :T gps<CR>
nnoremap <Leader>gb :T git blame %<CR>
nnoremap <Leader>ga :T git add %<CR>
nnoremap <Leader>gd :T git diff %<CR>
nnoremap <Leader>gc :T git add %<CR>:T git commit % -m "
nnoremap <Leader>g. :T git add $(dirname %)<CR>:T git commit $(dirname %)<CR>
nnoremap <Leader>gl :T gl %<CR>

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
" When jump to next match also center screen
noremap n nzz
noremap N Nzz

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" More logical Y (defaul was alias for yy)
nnoremap Y y$

" Quick replay q macro
nnoremap Q @q

" Cancel terminal mode with ,escape
tnoremap <Leader><ESC> <C-\><C-n>

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

" After block yank and paste, move cursor to the end of operated text
" Also, don't copy over-pasted text in visual mode
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Omnicomplete menu
set completeopt-=preview                    " Don't show preview scratch buffers
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" Insert mode cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 

" lexima latex rules
call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})

" CamelCaseMotion rules
call camelcasemotion#CreateMotionMappings('<leader>')

" Deoplete
let g:deoplete#enable_at_startup = 1

" Latex
let g:tex_flavor='latex'

set number
set hidden

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

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'tab': {
      \   'active': [ 'tabnum', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'filename', 'modified' ]
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'capslock' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'capslock': '%{exists("*CapsLockStatusline")?CapsLockStatusline():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
