" default
set autoindent
set smartindent
set expandtab
set tabstop=2       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=2    " used in auto/smartindent
set softtabstop=2   " follow tabstop

" per filetype
augroup MyIndentGroup
    " et:expandtab, ts:tabstop, sts:softtabstop, sw:shiftwidth
    autocmd!
    autocmd FileType dockerfile setlocal noet ts=4 sw=4
    autocmd FileType gitconfig  setlocal noet ts=4 sw=4
    autocmd FileType vim        setlocal      ts=4 sw=4
    autocmd FileType zsh        setlocal      ts=4 sw=4
augroup END
