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
" commenting gcc (line) or gc{motion}
Plug 'tomtom/tcomment_vim'
" Asynchronous completion
Plug 'Shougo/deoplete.nvim'
" Buffers on top
Plug 'ap/vim-buftabline'
" Fugitive for git viewer
Plug 'tpope/vim-fugitive'
" Git log viewer
Plug 'gregsexton/gitv'
" Git changes on lines
Plug 'airblade/vim-gitgutter'
" Unix commands
Plug 'tpope/vim-eunuch'
" Quickly jump with fFtT
Plug 'unblevable/quick-scope'
" Use cs"'
Plug 'tpope/vim-surround'
" Expand visual with v
Plug 'terryma/vim-expand-region'
" Close buffers/windows with same command
Plug 'mhinz/vim-sayonara'
" Autocorrect common spelling mistakes
Plug 'chip/vim-fat-finger'
" Man reading in vim
Plug 'jez/vim-superman'
" % match additions
" Plug 'edsono/vim-matchit'
" .
Plug 'tpope/vim-repeat'
" Ggrep and replace everything (search replace all files): 
" :Ggrep string :Qargs :argdo %s/string/replace/cg :argdo
Plug 'nelstrom/vim-qargs' 
" Exchange words cx{motion} and X (v) and cxc unselect
Plug 'tommcdo/vim-exchange'
" File explorer netrw enhancement
Plug 'tpope/vim-vinegar'
" Additional text objects: cin) -> change in parentheses
Plug 'wellle/targets.vim'

call plug#end()

if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

syntax on
filetype plugin indent on
set foldmethod=marker                       " Markers are used to specify folds.
set foldlevel=1                             " Start folding automatically from level 1
set fillchars="fold: " 

function! NeoFunc(...)
  :let g:neomake_open_list = 0
  :Neomake
endfunction

" Toggle neomake open list (currently can not be done silently)
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

" ====== Undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" ================ Git ===============================
nnoremap <Leader>gs :T git status<CR>
nnoremap <Leader>gpl :T git pull<CR>
nnoremap <Leader>gps :T git push<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>ga :Gwrite<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gwrite<CR>:Gcommit -m "
nnoremap <Leader>g. :T git add $(dirname %)<CR>:T git commit $(dirname %) -m "
nnoremap <Leader>gl :Gitv<CR>

" General
set visualbell                  "No sounds

nnoremap <Leader>w :w<CR>

" ================ Color Scheme =====================
set background=dark
colorscheme solarized

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

" Yank to EOL (default was alias for yy)
nnoremap Y y$

" Quick replay q macro
nnoremap Q @q

" Cancel terminal mode
tnoremap <M-t> <C-\><C-n>

" ==== Buffers ====
" = Use M- instead of Leader because of space in terminal
" Navigate buffers and windows from terminal
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
tnoremap <M-n> <C-\><C-n>:bnext<CR>
tnoremap <M-p> <C-\><C-n>:bprevious<CR>
" Close buffers from terminal
tnoremap <M-q><M-q> <C-\><C-n>:Sayonara<CR>
tnoremap <M-q><M-j> <C-\><C-n><C-w>j:Sayonara<CR>
tnoremap <M-q><M-l> <C-\><C-n><C-w>l:Sayonara<CR>
tnoremap <M-q><M-k> <C-\><C-n><C-w>k:Sayonara<CR>
tnoremap <M-q><M-h> <C-\><C-n><C-w>h:Sayonara<CR>

" Navigate buffers and windows
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap <M-n> :bnext<CR>
nnoremap <M-p> :bprevious<CR>
" Close buffers
nnoremap <M-q><M-q> :Sayonara<CR>
nnoremap <M-q><M-j> <C-w>j:Sayonara<CR>
nnoremap <M-q><M-l> <C-w>l:Sayonara<CR>
nnoremap <M-q><M-k> <C-w>k:Sayonara<CR>
nnoremap <M-q><M-h> <C-w>h:Sayonara<CR>
" ==== Buffers End ====

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
call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'tex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'tex'})

" Deoplete
let g:deoplete#enable_at_startup = 1

" quick-scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Sayonara
" Ask if it is last window
let g:sayonara_confirm_quit = 1

" NeoTerm
let g:neoterm_size=60
let g:neoterm_position='vertical'

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

" Easier window switching
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Highlight VCS conflict markers"{{{
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
"}}}

" Link highlight groups to improve buftabline colors"{{{
hi! link BufTabLineCurrent Identifier
hi! link BufTabLineActive Comment
hi! link BufTabLineHidden Comment
hi! link BufTabLineFill Comment

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
