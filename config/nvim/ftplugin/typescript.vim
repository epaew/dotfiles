function! SetTypeScriptLinter(dirname)
    let l:package_json = findfile("package.json", a:dirname . ";")
    if l:package_json ==# ''
        let b:ale_linters = ['deno']
    else
        let b:ale_linters = ['eslint', 'prettier', 'tsserver']
    endif
endfunction

call SetTypeScriptLinter(expand("%:p:h"))
