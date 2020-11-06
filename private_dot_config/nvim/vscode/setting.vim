function! s:splitNew(...)
	let file = a:2
	call s:split(a:1, file == '' ? '__vscode_new__' : file)
endfunction
" Navigation
nnoremap <silent> <space>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <space>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <space>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <space>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <space>h :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <space>h :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <space>l :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <space>l :call VSCodeNotify('workbench.action.navigateRight')<CR>
