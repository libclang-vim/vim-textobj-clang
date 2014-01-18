function! s:select(func)
    let extent = call(a:func, [expand('%'), line('.'), col('.')])
    if empty(extent)
        return 0
    endif
    let pos = getpos('.')
    let start = [pos[0], extent.start.line, extent.start.column, pos[3]]
    let end = [pos[0], extent.end.line, extent.end.column, pos[3]]
    return ['v', start, end]
endfunction

function! textobj#clang#any_select_i()
    return s:select('libclang#location#inner_definition_extent')
endfunction

function! textobj#clang#function_select_i()
    return s:select('libclang#location#function_extent')
endfunction

function! textobj#clang#statement_select_i()
    return s:select('libclang#location#statement_extent')
endfunction

function! textobj#clang#expression_select_i()
    return s:select('libclang#location#expression_extent')
endfunction

function! textobj#clang#parameter_select_i()
    return s:select('libclang#location#parameter_extent')
endfunction

function! textobj#clang#namespace_select_i()
    return s:select('libclang#location#namespace_extent')
endfunction

function! textobj#clang#under_cursor_select_i()
    return s:select('libclang#location#extent')
endfunction

function! textobj#clang#any_select_i()
    return s:select('libclang#location#class_extent')
endfunction
