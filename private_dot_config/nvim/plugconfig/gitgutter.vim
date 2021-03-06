let g:gitgutter_sign_added                   = '▎+'
let g:gitgutter_sign_modified                = '▎!'
let g:gitgutter_sign_removed                 = '▎-'
let g:gitgutter_sign_removed_first_line      = '▎-'
" let g:gitgutter_sign_removed_above_and_below = '▎-'
let g:gitgutter_sign_modified_removed        = '▎!'
let g:gitgutter_preview_win_floating = 1

let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
" Show line highlight
let g:gitgutter_highlight_linenrs = 1

highlight GitGutterAdd    guifg=#00c420 ctermfg=2
highlight GitGutterChange guifg=#00ffff ctermfg=3
highlight GitGutterDelete guifg=#fb4934 ctermfg=1
