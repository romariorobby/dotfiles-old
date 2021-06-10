" TODO <Space>tn take space
" source settings
luafile ~/.config/nvim/lua/settings.lua

function! s:splitNew(...)
	let file = a:2
	call s:split(a:1, file == '' ? '__vscode_new__' : file)
endfunction

function! s:openWhichKeyInVisualMode()
    normal! gv
    let visualmode = visualmode()
    if visualmode == "V"
        let startLine = line("v")
        let endLine = line(".")
        call VSCodeNotifyRange("whichkey.show", startLine, endLine, 1)
    else
        let startPos = getpos("v")
        let endPos = getpos(".")
        call VSCodeNotifyRangePos("whichkey.show", startPos[1], endPos[1], startPos[2], endPos[2], 1)
    endif
endfunction

command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

" Navigation
nnoremap <silent> <space>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <space>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <space>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <space>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <space>h :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <space>h :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <space>l :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <space>l :call VSCodeNotify('workbench.action.navigateRight')<CR>
nnoremap <silent> <space>v :call VSCodeNotify('workbench.action.splitEditor')<CR>
xnoremap <silent> <space>v :call VSCodeNotify('workbench.action.splitEditor')<CR>
nnoremap <silent> <space>s :call VSCodeNotify('workbench.action.splitEditorDown')<CR>
xnoremap <silent> <space>s :call VSCodeNotify('workbench.action.splitEditorDown')<CR>

nnoremap gr <Cmd>call VSCodeNotify('editor.action.goToReferences')<CR>
" WHY SPACE-SPACE ? it will double with Navigation key if use Only <Space> 
nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine
" Simulate same TAB behavior in VSCode
nmap <Tab> :Tabnext<CR>
nmap <S-Tab> :Tabprev<CR>
