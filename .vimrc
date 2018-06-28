"------------------------------------------------------------
" Dein Settings
"------------------------------------------------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.cache/dein'))
  call dein#begin(expand('~/.cache/dein'))
  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('itchyny/lightline.vim')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('scrooloose/nerdtree')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('thinca/vim-quickrun')
  call dein#add('tomtom/tcomment_vim')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-endwise')
  call dein#add('tyru/open-browser.vim')
  call dein#add('vim-scripts/AnsiEsc.vim')
  call dein#add('tmux-plugins/vim-tmux')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

"------------------------------------------------------------
" for OSTYPE Settings
"------------------------------------------------------------
let OSTYPE=system('uname')
if OSTYPE=="Darwin\n"
elseif OSTYPE=="Linux\n"
  set t_Co=256
endif


"------------------------------------------------------------
" NeoComplete Settings
"------------------------------------------------------------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3


"------------------------------------------------------------
" lightline Settings
"------------------------------------------------------------
set laststatus=2
set showtabline=2
let g:lightline = {
      \   'colorscheme' : 'wombat',
      \   'component_function' : {
      \     'cwd' : 'LightlineRelativecwd',
      \   },
      \ }
let g:lightline.tabline = {
      \   'left' : [['tabs']],
      \   'right' : [['cwd']],
      \ }
let g:lightline.tab_component_function = {
      \   'filename' : 'LightlineTabname',
      \ }

function! LightlineRelativecwd()
  return fnamemodify(getcwd(), ':~:.')
endfunction

function! LightlineTabname(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let _ = expand('#'.buflist[winnr - 1])
  return _ !=# '' ? _ : '[No Name]'
endfunction


"------------------------------------------------------------
" indent guides Settings
"------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1


"------------------------------------------------------------
" md syntax settings
"------------------------------------------------------------
augroup MyAutoGroup
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  autocmd FileType markdown hi! def link markdownItalic LineNr
augroup End


"------------------------------------------------------------
" vim-quickrun settings
"------------------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {'outputter': 'browser'}


"------------------------------------------------------------
" Colorscheme and Highlight Settings
"------------------------------------------------------------
syntax on
colorscheme desert

hi Normal ctermbg=NONE
hi Pmenu ctermbg=5
"hi PmenuSel ctermbg=1
hi PmenuSbar ctermbg=5


"------------------------------------------------------------
" Common Settings
"------------------------------------------------------------
set cursorline
set nohlsearch
set cursorcolumn
set wildmenu wildmode=list:longest
set encoding=utf-8

set clipboard=unnamed
set directory=~/.vim ""set swapfiles directory

set number
set ruler
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set nowrapscan
set incsearch
set backspace=2

set expandtab
set tabstop=2
set shiftwidth=2

set autoindent
set smartindent

"------------------------------------------------------------
" Common Settings (key maps)
"------------------------------------------------------------
nmap t [Tag]
nnoremap [Tag] <Nop>

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
