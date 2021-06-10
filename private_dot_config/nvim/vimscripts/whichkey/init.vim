let g:which_key_timeout = 10

let g:which_key_display_names = {'<CR>': '↵', '<TAB>': '⇆'} 

nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Time out 
" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
set timeoutlen=500


" let g:which_key_vertical = 0
" let g:which_key_floating_relative_win = 1

let g:which_key_use_floating_win = 0
" FIXME: Lets see if change this value fix whichkey goes all the way to the
" top when you hit bind quickly
let g:which_key_max_size = 50

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
" let g:which_key_map['s'] = [ '<C-W>s'                           , 'split below']
" let g:which_key_map['v'] = [ '<C-W>v'                           , 'split right']
" let g:which_key_map['h'] = [ '<C-W>h'                           , 'Window Left']
" let g:which_key_map['j'] = [ '<C-W>j'                           , 'Window Bottom']
" let g:which_key_map['k'] = [ '<C-W>k'                           , 'Window Up']
" let g:which_key_map['l'] = [ '<C-W>l'                           , 'Window Right']
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
" Hide some binding
let g:which_key_map.h = 'which_key_ignore'
let g:which_key_map.j = 'which_key_ignore'
let g:which_key_map.k = 'which_key_ignore'
let g:which_key_map.l = 'which_key_ignore'
let g:which_key_map.s = 'which_key_ignore'
let g:which_key_map.v = 'which_key_ignore'
" let g:which_key_map['/'] = 'which_key_ignore'

" nnoremap <F5> :lua require("nabla").replace_current()<CR>

" ACTIONS
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'h' : [':let @/ = ""'            , 'remove search highlight'],
      \ 'l' : [':Bracey'                 , 'start live server'],
      \ 'x' : [':.!sh'           		 , 'Exec Shell on cursor line'],
      \ 'L' : [':BraceyStop'             , 'stop live server'],
      \ 'r' : [':BraceyReload'           , 'restart live server'],
      \ 'd' : [':DiscordUpdatePresence'  , 'Discord Presence'],
      \ 'm' : [':MarkdownPreview'        , 'markdown preview'],
      \ 'g' : [':Glow'                   , 'Markdown Glow Preview'],
      \ 'M' : [':MarkdownPreviewStop'    , 'markdown preview stop'],
      \ 's' : [':lua require("nable".replace_current()<CR>'    , 'Scientific Nabla'],
      \ }

"" BUFFER 
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ 'J' : [':BufferMoveNext'        , 'Move Buffer Next'],
      \ 'K' : [':BufferMovePrevious'    , 'Move Buffer Prev'],
      \ 'b' : [':BufferPick'            , 'pick buffer'],
      \ 'd' : [':bdelete'               , 'delete-buffer'],
      \ 'c' : [':bdelete'               , 'delete-buffer'],
      \ 'D' : [':BufferOrderByDirectory', 'order by directory'],
      \ 'L' : [':BufferOrderByLanguage' , 'order by language'],
      \ 'g' : ['bfirst'                 , 'first-buffer'],
      \ 'G' : ['blast'                  , 'last buffer'],
      \ 'n' : ['bnext'                  , 'next-buffer'],
      \ 'p' : ['bprevious'              , 'previous-buffer'],
      \ '/' : [':Telescope buffers'     , 'Telescope buffers'],
      \ 'h' : ['bnext'                  , 'next-buffer'],
      \ 'l' : ['bprevious'              , 'previous-buffer'],
      \ }

"CODE
let g:which_key_map.c = {
      \ 'name' : '+code(+lsp)' ,
	  \ 'a' : [':Lspsaga code_action', 'Code Action'],
	  \ 'r' : [':Lspsaga rename', 'Rename '],
	  \ 'f' : [':Lspsaga lsp_finder', 'Lsp finder'],
	  \ 'p' : [':Lspsaga preview_definition', 'Preview Definition'],
	  \ 'L' : [':Lspsaga show_line_diagnostics', 'Line diagnostics'],
	  \ 'd' : [':Telescope lsp_document_diagnostics', 'Document diagnostics'],
	  \ 'D' : [':Telescope lsp_workspace_diagnostics', 'Workspace diagnostics'],
	  \ 's' : [':Telescope lsp_document_symbols', 'Document Sumbols'],
	  \ 'S' : [':Telescope lsp_workspace_symbols', 'Workspace Symbols'],
	  \ 't' : [':Vista!!', 'View and Search Tags'],
	  	\ 'x': {
		\ 'name': '+lsp',
		\ 'i' : [':LspInfo', 'Lsp Info'],
		\ }
      \ }

" FIND
let g:which_key_map.f = {
      \ 'name' : '+find & replace' ,
      \ 'f' : [':Telescope find_files'     , 'Find Files'],
      \ 't' : [':lua require("qs-telescope").edit_neovim()<CR>', 'Find Neovim Dir'],
      \ 'm' : [':Telescope media_files'     , 'Media Files'],
      \ 'r' : [':Telescope oldfiles'     , 'Recent Files'],
      \ 's' : [':luafile %'     , 'Source Files'],
      \ 'F' : [':Telescope find_files theme=get_dropdown winblend=5'     , 'Find Files'],
      \ 'g' : [':Telescope live_grep'      , 'Grep File'],
      \ 'c' : [':!compiler %'                    , ' Compile File with Compiler' ],
      \ 'l' : [':Lf'                       , 'Lf File manager'],
      \ }

" GIT
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                   , 'add all'],
      \ 'c' : [':Git Commit'                  , 'Commit' ],
      \ 'b' : [':GBrowse'                     , 'Browse' ],
      \ 'B' : [':Git blame'                   , 'Blame' ],
      \ 'd' : [':Git diff'                    , 'Diff' ],
      \ 'D' : [':Gdiffsplit'                  , 'Diff Split' ],
      \ 'g' : [':Gstatus'                     , 'Status' ],
      \ 'l' : [':Git log'                     , 'Log'],
      \ 'm' : ['<Plug>(git-messenger)'        , 'Message'],
      \ 't' : [':GitGutterToggle'             , 'toggle signs'],
      \ 'T' : [':GitGutterSignsToggle'        , 'toggle signs'],
      \ 'p' : [':Git push'                    , 'Push'],
      \ 'P' : [':Git pull'                    , 'Pull'],
      \ 'v' : [':GV'                          , 'view commits'],
      \ 'V' : [':GV!'                         , 'view buffer commits'],
      \ }
      " \ 'h' : [':PreviewHunk' , 'Preview Hunk' ],
      " \ 'j' : [':NextHunk'    , 'Next Hunk' ],
      " \ 'k' : [':PrevHunk'    , 'Previous Hunk' ],
      " \ '[' : [':PrevHunk'    , 'Previous Hunk' ],
      " \ ']' : [':NextHunk'    , 'Next Hunk' ],
	  
"HELP
let g:which_key_map.H = {
      \ 'name' : '+Help/Page' ,
      \ 'k' : [':map<CR>'             	, 'See recent keys'],
      \ 'H' : [':help'                	, 'Help'],
      \ 'v' : [':Telescope vim_options' , 'Vim Options Setting'],
      \ 't' : [':Telescope colorscheme' , 'Load Theme'],
      \ 'm' : [':Telescope man_pages' 	, 'Man Pages'],
      \ 'p' : [':Telescope builtin' 	, 'Telescope  Picker List'],
      	\ 'c' : {
		\ 'name' : '+Commands',
		\ 'h' : [':Telescope help_tags' 	, 'Help (Telescope)'],
		\ ':' : [':Telescope commands' 	, 'List Available Commands'],
		\ },
      \ }

" LSP
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

" BOOKMARK
" Idk if i'm gonna continue using '<leader>//' for commenting
let g:which_key_map.m = {
      \ 'name': '+Marks',
      \ 'a' : [':BookmarkAnnotate'   , 'Annotate'],
      \ 'm' : [':BookmarkToggle'   , 'toggle'],
      \ 's' : [':BookmarkShowAll'   , 'Show All '],
      \ 'j' : [':BookmarkNext'   , 'next mark'],
      \ 'c' : [':BookmarkClear'   , 'Clear Bookmark Cur Buf'],
      \ 'C' : [':BookmarkClearAll' , 'Clear Bookmark All Buf'],
      \ 'w' : [':BookmarkSave'   , 'Save to a file'],
      \ 'l' : [':BookmarkLoad'   , 'Load a Bookmark file'],
      \ 'k' : [':BookmarkPrev'   , 'prev mark'],
      \ 'f' : [':Telescope marks'        , 'Jump to the marks']
      \ }

"NOTES
let g:which_key_map.n = {
	  \ 'name' : '+notes' ,
	  \ 't' : ['<Plug>OrgSetTags' , 'Org Set Tags']
	  \ }
let g:which_key_map.N = {
      \ 'name' : '+Notes' ,
      \ 'j' : ['<Plug>(wiki-journal)'       , 'Journal Today'],
      \ 'l' : ['<Plug>(wiki-journal-next)'  , 'Journal Next'],
      \ 'h' : ['<Plug>(wiki-journal-prev)'  , 'Journal Prev'],
      \ 'w' : ['<Plug>(wiki-index)'         , 'Wiki Index'],
      \ 'r' : ['<Plug>(wiki-reload)'        , 'Wiki Reload'],
      \ 'n' : ['<Plug>(wiki-open)'          , 'wiki open'],
      \ 'z' : ['<Plug>(wiki-link-toggle)'   , 'wiki toggle'],
      \ 'c' : ['<Plug>(wiki-list-toggle)'   , 'Toggle TODO'],
      \ 'b' : ['<Plug>(wiki-graph-find-backlinks)'   , 'backlinks'],
	    \ 't' : {
		\ 'name' : '+TaskWarrior',
		\ 'a' : [':TaskWiki'   , 'Task Tags'],
		\ 'd' : [':TaskWikiDelete'   , 'Delete Task'],
		\ 'c' : [':TaskWikiCalendar'   , 'Calendar'],
		\ 's' : [':TaskWikiStart'   , 'Start Task'],
		\ 'S' : [':TaskWikiStop'   , 'Stop Task'],
		\ 'u' : [':TaskWiki'   , 'Stop Task'],
		\ 'i' : [':TaskWikiInfo'   , 'Info Task'],
		\ 'I' : [':TaskWikiStats'   , 'Stats Task'],
		\ 't' : [':TaskWikiTags'   , 'Task Tags'],
		\ 'e' : [':TaskWikiEdit'   , 'Edit Task'],
		\ 'E' : [':TaskWikiMod'   , 'Modify Task'],
		\ 'l' : [':TaskWikiLink'   , 'Task Linking?idk'],
		\ 'p' : [':TaskWikiProjects'   , 'Project'],
		\ 'z' : [':TaskWikiChooseProject'   , 'Choose Projects'],
		\ 'Z' : [':TaskWikiChooseTag'   , 'Choose Tags'],
		\ 'g' : [':TaskWikiGrid'   , 'Grid'],
		\ 'P' : [':TaskWikiProjectsSummary'   , 'Project Summary'],
		\ 'b' : {
		\ 'name' : '+Burndown',
			\ 'd' : [':TaskWikiBurndownDaily'   , 'Daily'],
			\ 'w' : [':TaskWikiBurndownWeekly'   , 'Weekly'],
			\ 'm' : [':TaskWikiBurndownMonthly'   , 'Monthly'],
			\ },
		\ 'h' : {
		\ 'name' : '+(G)History',
			\ 'A' : [':TaskWikiHistoryAnnual'   , 'Annual'],
			\ 'M' : [':TaskWikiHistoryMonthly'   , 'Monthly'],
			\ 'a' : [':TaskWikiGhistoryAnnual'   , '(G) Annual'],
			\ 'm' : [':TaskWikiGhistoryMonthly'   , '(G) Monthly'],
		\ },
		\ },
      \ }

"TOGGLE
let g:which_key_map.t = {
      \ 'name' : '+Toggle' ,
      \ 'z' : [':call ToggleHiddenAll()<CR>'    , 'Zen Mode'],
      \ 'u' : [':UndotreeToggle'                , 'Undotree'],
      \ 'n' : [':NvimTreeToggle'                , 'Nvimtree'],
      \ 'm' : [':Telescope file_browser theme=get_dropdown winblend=5'                , 'Nvimtree'],
      \ 'C' : [':HexokinaseToggle'              , 'Hexokinase'],
      \ 'c' : [':ColorizerToggle'               , 'Colorizer aka Color Highlight'],
      \ 'L' : [':call g:ToggleLineMode()<CR>'   , 'Line Mode'],
      \ 'g' : [':FloatermNew lazygit'   		, 'Lazygit'],
      \ 'd' : [':FloatermNew ncdu'   			, 'ncdu'],
      \ 't' : [':FloatermToggle'                , 'Terminal '],
      \ 'l' : [':FloatermNext'                  , 'Next Term '],
      \ 'h' : [':FloatermPrev'                  , 'Prev Term '],
      \ 'j' : [':FloatermNew'                   , 'New Term '],
      \ 'k' : [':FloatermKill'                  , 'Kill Term '],
      \ '/' : [':AutoPairsShortcutJump'         , 'Pairs jump'],
      \ }
    "\ 'n' : [':NERDTreeToggle'                , 'NerdTree'],

" WINDOWS
let g:which_key_map.w = {
      \ 'name' : '+window' ,
      \ 'w' : [':call WindowSwap#EasyWindowSwap()'  , 'Move Window'],
      \ 'c' : ['<C-W>c'                             , 'delete-window'],
      \ 'v' : [':vsplit'                            , 'Vertical split'],
      \ 's' : [':split'                             , 'Horizontal split'],
      \ '+' : ['<C-W>='                             , 'Balance Windows'],
      \ 'h' : ['<C-W>h'                             , 'Windows Left'],
      \ 'k' : ['<C-W>k'                             , 'Windows Up'],
      \ 'l' : ['<C-W>l'                             , 'Windows Right'],
      \ 'j' : ['<C-W>j'                             , 'Windows Bottom'],
      \ 'H' : ['<C-W>H'                             , 'Move Windows Left'],
      \ 'K' : ['<C-W>K'                             , 'Move Windows Up'],
      \ 'L' : ['<C-W>L'                             , 'Move Windows Right'],
      \ 'J' : ['<C-W>J'                             , 'Move Windows Bottom'],
      \ '\' : [':MaximizerToggle'                   , 'Maximizer Toggle'],
      \ '=' : [':vertical resize +5'                , 'Increase Width'],
      \ '-' : [':vertical resize -5'                , 'Decrease Width'],
      \ 'u' : [':resize +5'                         , 'Increase Height'],
      \ 'd' : [':resize -5'                         , 'Decrease Height'],
      \ }

let g:which_key_map['/'] = {
	  \ 'name' : '+search',
	  \ }

	  " \ '/' : [':CommentToggle', 'Toggle Commenting']
let g:which_key_map['<Tab>'] = {
      \ 'name' : '+Tabbing' ,
      \ 'c' : [':tabc'              , 'Close Tab'],
      \ 'n' : [':tabnew'            , 'New Tab'],
      \ 'h' : [':tabp'              , 'Prev Tab'],
      \ 'l' : [':tabn'              , 'Next Tab '],
      \ }

call which_key#register('<Space>', "g:which_key_map")
