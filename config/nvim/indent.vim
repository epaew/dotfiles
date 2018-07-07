" default
set autoindent
set smartindent
set expandtab
set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
set shiftwidth=4    " used in auto/smartindent
set softtabstop=0   " follow tabstop

" per filetype
augroup MyIndentGroup
    " et:expandtab, ts:tabstop, sts:softtabstop, sw:shiftwidth
    autocmd!
    autocmd FileType c          setlocal et ts=2 sts=2 sw=2
    autocmd FileType cpp        setlocal et ts=2 sts=2 sw=2
    autocmd FileType eruby      setlocal et ts=2 sts=2 sw=2
    autocmd FileType gitconfig  setlocal noet
    autocmd FileType ruby       setlocal et ts=2 sts=2 sw=2
    autocmd FileType slim       setlocal et ts=2 sts=2 sw=2
    autocmd FileType yaml       setlocal et ts=2 sts=2 sw=2
augroup END
