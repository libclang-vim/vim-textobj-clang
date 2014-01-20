if exists('g:loaded_textobj_clang')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:textobj_clang_more_mapping = get(g:, 'textobj_clang_more_mappings', 0)
let g:textobj_clang_include_headers = get(g:, 'textobj_clang_include_headers', 0)
let s:spec = {}

if g:textobj_clang_more_mapping
    let g:textobj_clang_mapping_kinds = get(g:, 'textobj_clang_kinds', ['any', 'class', 'function', 'expression', 'statement', 'parameter', 'namespace', 'under_cursor', 'most_inner'])
    for s:name in g:textobj_clang_mapping_kinds
        let s:spec[s:name] = {
                    \ 'select-i' : 'i;'.s:name[0],
                    \ '*select-i-function*' : 'textobj#clang#' . s:name . '_select_i',
                    \ }
    endfor
else
    let s:spec['-'] = {
                \ 'select-i' : 'i;', '*select-i-function*' : 'textobj#clang#under_cursor_select_i',
                \ 'select-a' : 'a;', '*select-a-function*' : 'textobj#clang#any_select_i',
                \ }
endif

call textobj#user#plugin('clang', s:spec)

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_textobj_clang = 1
