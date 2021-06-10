nnoremap <leader>cc :w <bar> !compiler %<CR>
nnoremap <leader>cC :silent w <bar> !compiler % >/dev/null<CR><CR>
function! OpenWith()
    let curFile = substitute(bufname("%"), ".tex", ".pdf", "")
    execute "silent !opout " curFile "&"
endfunction

nnoremap <leader>co :call OpenWith()<CR>
autocmd VimLeave *.tex !texclear %
 
