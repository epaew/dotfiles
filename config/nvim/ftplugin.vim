augroup MyFTPluginGroup
    autocmd!
    autocmd FileType markdown hi! def link markdownItalic LineNr
    autocmd FileType quickrun AnsiEsc
    autocmd FileType vue syntax sync fromstart
augroup END
