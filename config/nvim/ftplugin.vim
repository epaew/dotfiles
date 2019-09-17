" Define Custom FileTypes
augroup MyFileTypeGroup
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
    autocmd BufNewFile,BufRead .gemrc       setlocal filetype=yaml
    autocmd BufNewFile,BufRead .{irb,pry}rc setlocal filetype=ruby
    autocmd BufNewFile,BufRead *_spec.rb    setlocal filetype=ruby.rspec
    autocmd BufNewFile,BufRead *.slim       setlocal filetype=slim
augroup End

augroup MyFileTypePluginGroup
    autocmd!
    autocmd FileType markdown hi! def link markdownItalic LineNr
    autocmd FileType vue syntax sync fromstart
augroup End
