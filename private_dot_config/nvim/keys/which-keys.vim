" let @s = 'veS"'

let mapleader=" "
let g:maplocalleader = 'm'

" Map leader to which_key
nnoremap <silent> <leader><Space> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader><Space> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'} 
" Time out 
" let g:which_key_timeout = 10
" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key_max_size = 0

let g:which_key_position = 'botright'

" " Change the colors if you want
" highlight default link WhichKey          Operator
" highlight default link WhichKeySeperator DiffAdded
" highlight default link WhichKeyGroup     Identifier
" highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
" let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle'        , 'comment' ]
" let g:which_key_map['e'] = [ ':CocCommand explorer'             , 'explorer' ]
" let g:which_key_map['f'] = [ ':Files'                           , 'search files' ]
" let g:which_key_map['r'] = [ ':Ranger'                          , 'ranger' ]
" let g:which_key_map['S'] = [ ':Startify'                        , 'start screen' ]
" let g:which_key_map['T'] = [ ':Rg'                              , 'search text' ]
let g:which_key_map['s'] = [ '<C-W>s'                           , 'split below']
let g:which_key_map['v'] = [ '<C-W>v'                           , 'split right']
let g:which_key_map['h'] = [ '<C-W>h'                           , 'Window Left']
let g:which_key_map['j'] = [ '<C-W>j'                           , 'Window Bottom']
let g:which_key_map['k'] = [ '<C-W>k'                           , 'Window Up']
let g:which_key_map['l'] = [ '<C-W>l'                           , 'Window Right']
" let g:which_key_map['z'] = [ 'Goyo'                             , 'zen' ]
" let g:which_key_map['W'] = [ ':call WindowSwap#EasyWindowSwap()'  , 'move window' ]
" let g:which_key_map[';'] = [ ':Commands'                                       , 'commands' ]

" s is for search
" let g:which_key_map.s = {
"       \ 'name' : '+search' ,
"       \ '/' : [':History/'     , 'history'],
"       \ ';' : [':Commands'     , 'commands'],
"       \ 'a' : [':Ag'           , 'text Ag'],
"       \ 'b' : [':BLines'       , 'current buffer'],
"       \ 'B' : [':Buffers'      , 'open buffers'],
"       \ 'c' : [':Commits'      , 'commits'],
"       \ 'C' : [':BCommits'     , 'buffer commits'],
"       \ 'f' : [':Files'        , 'files'],
"       \ 'g' : [':GFiles'       , 'git files'],
"       \ 'G' : [':GFiles?'      , 'modified git files'],
"       \ 'h' : [':History'      , 'file hr>istory'],
"       \ 'H' : [':History:'     , 'command history'],
"       \ 'l' : [':Lines'        , 'lines'] ,
"       \ 'm' : [':Marks'        , 'marks'] ,
"       \ 'M' : [':Maps'         , 'normal maps'] ,
"       \ 'p' : [':Helptags'     , 'help tags'] ,
"       \ 'P' : [':Tags'         , 'project tags'],
"       \ 's' : [':Snippets'     , 'snippets'],
"       \ 'S' : [':Colors'       , 'color schemes'],
"       \ 't' : [':Rg'           , 'text Rg'],
"       \ 'T' : [':BTags'        , 'buffer tags'],
"       \ 'w' : [':Windows'      , 'search windows'],
"       \ 'y' : [':Filetypes'    , 'file types'],
"       \ 'z' : [':FZF'          , 'FZF'],
"       \ } \ 'v' : [':vsplit'                            , 'Vsplit'],
      " \ 's' : [':split'                             , 'Split'],
      "

"a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'h' : [':let @/ = ""'            , 'remove search highlight'],
      \ 'l' : [':Bracey'                 , 'start live server'],
      \ 'L' : [':BraceyStop'             , 'stop live server'],
      \ 'r' : [':BraceyReload'           , 'restart live server'],
      \ 'd' : [':DiscordUpdatePresence'  , 'Discord Presence'],
      \ 'm' : [':MarkdownPreview'        , 'markdown preview'],
      \ 'M' : [':MarkdownPreviewStop'    , 'markdown preview stop'],
      \ }
let g:which_key_map.z = {
      \ 'name' : '+Tabbing' ,
      \ 'c' : [':tabc'              , 'Close Tab'],
      \ 'n' : [':tabnew'            , 'New Tab'],
      \ 'h' : [':tabp'              , 'Prev Tab'],
      \ 'l' : [':tabn'              , 'Next Tab '],
      \ }
let g:which_key_map.w = {
      \ 'name' : '+window' ,
      \ 'w' : [':call WindowSwap#EasyWindowSwap()'  , 'Move Window'],
      \ 'c' : ['<C-W>c'                             , 'delete-window'],
      \ 'v' : [':vsplit'                            , 'Vertical split'],
      \ 's' : [':split'                             , 'Horizontal split'],
      \ '=' : ['<C-W>='                             , 'Balance Windows'],
      \ 'h' : ['<C-W>h'                             , 'Windows Left'],
      \ 'k' : ['<C-W>k'                             , 'Windows Up'],
      \ 'l' : ['<C-W>l'                             , 'Windows Right'],
      \ 'j' : ['<C-W>j'                             , 'Windows Bottom'],
      \ '\' : ['<C-W>|'                             , 'Sneak Windows'],
      \ '+' : [':vertical resize +5'                , 'Increase Width'],
      \ '-' : [':vertical resize -5'                , 'Decrease Width'],
      \ 'u' : [':resize +5'                         , 'Increase Height'],
      \ 'd' : [':resize -5'                         , 'Decrease Height'],
      \ }
let g:which_key_map.f = {
      \ 'name' : '+find & replace' ,
      \ 'f' : [':Telescope find_files'     , 'Find Files'],
      \ '/' : [':Telescope live_grep'      , 'Grep File'],
      \ 'w' : [':Lf'                       , 'Lf File manager'],
      \ 'p' : [':Farr --source=rgnvim'     , 'project'],
      \ }
let g:which_key_map.t = {
      \ 'name' : '+Toggle' ,
      \ 'z' : [':call ToggleHiddenAll()<CR>'    , 'Zen Mode'],
      \ 'u' : [':UndotreeToggle'                , 'Undotree'],
      \ 'C' : [':HexokinaseToggle'              , 'Hexokinase'],
      \ 'c' : [':ColorizerToggle'               , 'Colorizer aka Color Highlight'],
      \ 'L' : [':call g:ToggleLineMode()<CR>'   , 'Line Mode'],
      \ 't' : [':FloatermToggle'                , 'Terminal '],
      \ 'l' : [':FloatermNext'                  , 'Next Term '],
      \ 'h' : [':FloatermPrev'                  , 'Prev Term '],
      \ 'j' : [':FloatermNew'                   , 'New Term '],
      \ 'k' : [':FloatermKill'                  , 'Kill Term '],
      \ '/' : [':AutoPairsShortcutJump'         , 'Pairs jump'],
      \ }
    "\ 'n' : [':NERDTreeToggle'                , 'NerdTree'],
" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '>' : [':BufferMoveNext'        , 'move next'],
      \ '<' : [':BufferMovePrevious'    , 'move prev'],
      \ '1' : [':BufferGoto 1'          , 'buffer 1'],
      \ '2' : [':BufferGoto 2'          , 'buffer 2'],
      \ '3' : [':BufferGoto 3'          , 'buffer 3'],
      \ '4' : [':BufferGoto 4'          , 'buffer 4'],
      \ '5' : [':BufferGoto 5'          , 'buffer 5'],
      \ '6' : [':BufferGoto 6'          , 'buffer 6'],
      \ '7' : [':BufferGoto 7'          , 'buffer 7'],
      \ '8' : [':BufferGoto 8'          , 'buffer 8'],
      \ '9' : [':BufferGoto 9'          , 'buffer 9'],
      \ '0' : [':BufferGoto 0'          , 'buffer 0'],
      \ 'b' : [':BufferPick'            , 'pick buffer'],
      \ 'd' : [':Bdelete'               , 'delete-buffer'],
      \ 'c' : [':Bdelete'               , 'delete-buffer'],
      \ 'D' : [':BufferOrderByDirectory', 'order by directory'],
      \ 'g' : ['bfirst'                 , 'first-buffer'],
      \ 'G' : ['blast'                  , 'last buffer'],
      \ 'L' : [':BufferOrderByLanguage' , 'order by language'],
      \ 'n' : ['bnext'                  , 'next-buffer'],
      \ 'p' : ['bprevious'              , 'previous-buffer'],
      \ 'h' : ['bnext'                  , 'next-buffer'],
      \ 'l' : ['bprevious'              , 'previous-buffer'],
      \ '/' : [':Telescope buffers'     , 'Telescope buffers'],
      \ }
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                   , 'add all'],
      \ 'c' : [':Git Commit'                  , 'Commit' ],
      \ 'b' : [':GBrowse'                     , 'Browse' ],
      \ 'B' : [':Git blame'                   , 'Blame' ],
      \ 'd' : [':Git diff'                    , 'Diff' ],
      \ 'D' : [':Gdiffsplit'                  , 'Diff Split' ],
      \ 'g' : [':Gstatus'                     , 'Status' ],
      \ 'h' : ['<Plug>(GitGutterPreviewHunk)' , 'Preview Hunk' ],
      \ 'j' : ['<Plug>(GitGutterNextHunk)'    , 'Next Hunk' ],
      \ 'k' : ['<Plug>(GitGutterPrevHunk)'    , 'Previous Hunk' ],
      \ '[' : ['<Plug>(GitGutterPrevHunk)'    , 'Previous Hunk' ],
      \ ']' : ['<Plug>(GitGutterNextHunk)'    , 'Next Hunk' ],
      \ 'l' : [':Git log'                     , 'Log'],
      \ 'm' : ['<Plug>(git-messenger)'        , 'Message'],
      \ 't' : [':GitGutterToggle'             , 'toggle signs'],
      \ 'T' : [':GitGutterSignsToggle'        , 'toggle signs'],
      \ 'p' : [':Git push'                    , 'Push'],
      \ 'P' : [':Git pull'                    , 'Pull'],
      \ 'v' : [':GV'                          , 'view commits'],
      \ 'V' : [':GV!'                         , 'view buffer commits'],
      \ }
" let g:which_key_map.l = {
"       \ 'name' : '+lsp' ,
"       \ ' ' : [':'  , ''],
"       \ ' ' : [':'  , ''],
"       \ ' ' : [':'  , ''],
"       \ ' ' : [':'  , ''],
"       \ ' ' : [':'  , ''],
"       \ ' ' : [':'  , ''],
"       \ ' ' : [':'  , ''],
"       \ ' ' : [':'  , ''],
"       \ }
call which_key#register('<Space>', "g:which_key_map")

