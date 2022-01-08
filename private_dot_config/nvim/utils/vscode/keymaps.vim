source ~/.config/nvim/utils/vscode/func.vim
set timeoutlen=300
set ttimeoutlen=0
" let mapleader = " "
" let maplocalleader = " m" -- <Space>m

nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
xnoremap <silent> <Space> :<C-u>call <SID>openWhichKeyInVisualMode()<CR>

" Simulate same TAB behavior in VSCode
nmap <Tab> :Tabnext<CR>
nmap <S-Tab> :Tabprev<CR>

nnoremap <silent> <Space>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <Space>j :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <Space>k :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <Space>k :call VSCodeNotify('workbench.action.navigateUp')<CR>

nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <Space>h :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <Space>h :call VSCodeNotify('workbench.action.navigateLeft')<CR>

nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
nnoremap <silent> <Space>l :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <Space>l :call VSCodeNotify('workbench.action.navigateRight')<CR>

nnoremap <silent> <Space>v :call VSCodeNotify('workbench.action.splitEditor')<CR>
xnoremap <silent> <Space>v :call VSCodeNotify('workbench.action.splitEditor')<CR>

nnoremap <silent> <Space>s :call VSCodeNotify('workbench.action.splitEditorDown')<CR>
xnoremap <silent> <Space>s :call VSCodeNotify('workbench.action.splitEditorDown')<CR>
