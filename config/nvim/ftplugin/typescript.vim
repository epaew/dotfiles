function! SetTypeScriptLinter(dirname)
    let node_modules = expand(finddir("node_modules", a:dirname . ";"))
    if node_modules ==# ''
        let b:ale_linters = ['deno']
    else
        let b:ale_linters = ['eslint', 'prettier', 'tsserver']
    endif
endfunction

call SetTypeScriptLinter(expand("%:p:h"))
