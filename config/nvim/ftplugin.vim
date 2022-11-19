" Define Custom FileTypes
augroup MyFileTypeGroup
    autocmd!
    autocmd BufNewFile,BufRead *.jb setlocal filetype=ruby
augroup End

augroup MyFileTypePluginGroup
    autocmd!
    autocmd FileType markdown hi! def link markdownItalic LineNr
    autocmd FileType vue syntax sync fromstart
augroup End
