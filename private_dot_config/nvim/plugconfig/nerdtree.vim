
" Auto CD nerdtree to current dir opened
let g:NERDTreeChDirMode=2
let NERDTreeMapToggleHidden='.'
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'
" Auto Open Nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Auto Open NerdTree and on directory 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
