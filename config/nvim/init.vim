"------------------------------------------------------------
" Load Plugins
"------------------------------------------------------------
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.cache/dein'))
    call dein#begin(expand('~/.cache/dein'))

    call dein#load_toml('~/.config/nvim/dein/base.toml', { 'lazy': 0 })
    call dein#load_toml('~/.config/nvim/dein/lazy.toml', { 'lazy': 1 })
    call dein#load_toml('~/.config/nvim/dein/filetype.toml')

    call dein#end()
    call dein#save_state()
endif

if !has('vim_starting') && dein#check_install()
    call dein#install()
endif

" load ftplugins
filetype plugin indent on
syntax enable

"------------------------------------------------------------
" Define Custom FileTypes
"------------------------------------------------------------
augroup MyFileTypeGroup
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
    autocmd BufNewFile,BufRead .{irb,pry}rc setlocal filetype=ruby
    autocmd BufNewFile,BufRead *_spec.rb    setlocal filetype=ruby.rspec
    autocmd BufNewFile,BufRead *.slim       setlocal filetype=slim
augroup End


"------------------------------------------------------------
" Search
"------------------------------------------------------------
set incsearch
set nowrapscan
set showmatch
set smartcase
set whichwrap=b,s,h,l,<,>,[,]


"------------------------------------------------------------
" Style
"------------------------------------------------------------
silent if !dein#check_install('landscape.vim')
    colorscheme landscape
endif
set cursorline
set guicursor=
set nohlsearch
set nowrap
set number
set ruler

hi Normal ctermbg=NONE
hi Pmenu ctermbg=5
hi PmenuSbar ctermbg=5

" for vim-indent-guides
hi IndentGuidesOdd  ctermbg=darkgray
hi IndentGuidesEven ctermbg=NONE


"------------------------------------------------------------
" Others
"------------------------------------------------------------
set backspace=2
set clipboard=unnamedplus
set directory=~/.vim ""set swapfile's directory
set encoding=utf-8
set wildmenu wildmode=list:longest
