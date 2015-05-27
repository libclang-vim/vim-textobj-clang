Make text objects for various C and C++ blocks with power of clang
==================================================================

This vim plugin makes text objects for various C and C++ blocks, function, class, namespace, expression, statement and so on.

## Dependencies

- [vim-textobj-user](https://github.com/kana/vim-textobj-user)
- [libclang-vim](https://github.com/rhysd/libclang-vim)

If you use [neobundle.vim](https://github.com/Shougo/neobundle.vim), you can install this plugin easily as below.

```vim
NeoBundleLazy 'rhysd/libclang-vim', {
            \ 'build' : {
            \       'windows' : 'echo "Please build manually"',
            \       'mac' : 'make',
            \       'unix' : 'make',
            \   }
            \ }

NeoBundleLazy 'rhysd/vim-textobj-clang', {
            \ 'depends' : ['kana/vim-textobj-user', 'rhysd/libclang-vim'],
            \ 'autoload' : {
            \       'mappings' : [['xo', 'a;'], ['xo', 'i;']]
            \   }
            \ }
```

## Simple operator-pending mappings `i;` and `a;`

Operator-pending mappings `i;` and `a;` are available.  `i;` selects the element under cursor.  `a;` selects the most inner definition under cursor.

For example, see below code.

```cpp
int main()
{
    return 0;
}
```

When the cursor is placed at `return`, `i;` selects `return 0;` and `a;` selects whole `main()` function.
This is very simple example.  Clang can parse more complicated source files like Boost libraries.

Screenshot:

![screenshot](http://gifzo.net/82IlUtfW1g.gif)

## More complicated operator-pending mappings

If you set `g:textobj_clang_more_mappings` to `1`, many operator-pending mappings are defined.  As a default, mappings in a below table are defined.  You can control the number of the mappings with `g:textobj_clang_mapping_kinds`.

<table>
    <tr>
        <th>Mapping</th>
        <th>Block</th>
    </tr>
    <tr>
        <td>i;m</td>
        <td>select the most inner definition</td>
    </tr>
    <tr>
        <td>i;c</td>
        <td>select class blocks</td>
    </tr>
    <tr>
        <td>i;f</td>
        <td>select function blocks</td>
    </tr>
    <tr>
        <td>i;e</td>
        <td>select an expression</td>
    </tr>
    <tr>
        <td>i;s</td>
        <td>select an statement</td>
    </tr>
    <tr>
        <td>i;p</td>
        <td>select an parameter and a template parameter</td>
    </tr>
    <tr>
        <td>i;n</td>
        <td>select a namespace</td>
    </tr>
    <tr>
        <td>i;u</td>
        <td>select an element under cursor</td>
    </tr>
    <tr>
        <td>i;a</td>
        <td>select expression, statement, function, class or namespace</td>
    </tr>
</table>

## License

    The MIT License (MIT)

    Copyright (c) 2014 rhysd

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.

