set hidden
" Toggle Line mode
fun! g:ToggleLineMode()
:exe 'set nu!' &nu ? 'rnu!' : ''
endfun
"  Toggle Terminal
let g:term_buf = 0
let g:term_win = 0
function! Term_toggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
            set nocursorline
        endtry
        startinsert!
        let g:term_win = win_getid()

    endif
endfunction

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        exec ':silent BufferClose ' . old_name
        redraw!
    endif
endfunction

function! CopyFile()
    let old_name = expand('%')
    let new_name = input('New Copy Name: ')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        redraw!
    endif
endfunction
" will remove this when nvim api support this
"
" idk whay using tab not works so i put this and use Return to expand snippets

" imap <expr> <CR>    compe#confirm<CR>
" imap <expr> <TAB>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<TAB>'
" smap <expr> <TAB>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<TAB>'

" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" TODO: Move this to keymap when command! already supported in lua"
" this is kind sort of aliases?
command! Televim lua require 'qs-telescope'.find_neovim()
command! W w
