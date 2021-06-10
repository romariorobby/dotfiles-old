
runtime! ftplugin/dotoo.vim

function! ChangeTodo()
	normal! 0
	if search(join(g:org_state_keywords, '\|'), 'W',getline('.'))
		normal! ciw
		call feedkeys("a\<C-X>\<C-O>", 'i')
	else
		call search('\* ', 'W',getline('.'))
		exec 'normal! f '
		call feedkeys("a\<C-X>\<C-O>", 'i')
	endif
endfunction
nmap <buffer> <leader>nt :call ChangeTodo()<CR>
