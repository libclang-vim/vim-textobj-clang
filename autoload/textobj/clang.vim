function! s:prepare_temp_file()
    if g:textobj_clang_include_headers
        let temp_name = expand('%:p:h') . substitute(tempname(), '\W', '_', 'g') . (&filetype ==# 'c' ? '.c' : '.cpp')
        call writefile(getline(1, '$'), temp_name)
    else
        let temp_name = tempname() . (&filetype ==# 'c' ? '.c' : '.cpp')
        call writefile(map(getline(1, '$'), 'v:val =~# "^\\s*#include\\s*\\(<[^>]\\+>\\|\"[^\"]\\+\"\\)" ? "" : v:val'), temp_name)
    endif

    return temp_name
endfunction

function! s:select_extent(func)
    let temp_name = s:prepare_temp_file()
    try
        let extent = call(a:func, [temp_name, line('.'), col('.')])
    finally
        call delete(temp_name)
    endtry
    if empty(extent) || extent.start.file !=# extent.end.file
        return 0
    endif
    let pos = getpos('.')
    let start = [pos[0], extent.start.line, extent.start.column, pos[3]]
    let end = [pos[0], extent.end.line, extent.end.column, pos[3]]
    return ['v', start, end]
endfunction

function! textobj#clang#any_select_i()
    return s:select_extent('libclang#location#inner_definition_extent')
endfunction

function! textobj#clang#function_select_i()
    return s:select_extent('libclang#location#function_extent')
endfunction

function! textobj#clang#statement_select_i()
    return s:select_extent('libclang#location#statement_extent')
endfunction

function! textobj#clang#expression_select_i()
    return s:select_extent('libclang#location#expression_extent')
endfunction

function! textobj#clang#parameter_select_i()
    return s:select_extent('libclang#location#parameter_extent')
endfunction

function! textobj#clang#namespace_select_i()
    return s:select_extent('libclang#location#namespace_extent')
endfunction

function! textobj#clang#under_cursor_select_i()
    return s:select_extent('libclang#location#extent')
endfunction

function! textobj#clang#most_inner_select_i()
    return s:select_extent('libclang#location#class_extent')
endfunction

function! textobj#clang#any_select_i()
    let temp_name = s:prepare_temp_file()
    try
        let extents = filter(libclang#location#all_extents(temp_name, line('.'), col('.')), '!empty(v:val)')
    finally
        call delete(temp_name)
    endtry
    let len = len(extents)
    if len == 0
        return 0
    elseif len == 1
        let extent = extents[0]
    else
        let idx = 1
        while extents[idx] == extents[0]
            if idx == len - 1 | break | endif
            let idx += 1
        endwhile
        let extent = extents[idx]
    endif

    let pos = getpos('.')
    let start = [pos[0], extent.start.line, extent.start.column, pos[3]]
    let end = [pos[0], extent.end.line, extent.end.column, pos[3]]
    return ['v', start, end]
endfunction
