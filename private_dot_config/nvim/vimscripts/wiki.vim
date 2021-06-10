" 
" wiki.vim
" use date after name of the files eg foo.{date}
function FileFormat(name) abort
  let l:name = wiki#get_root() . '/' . a:name

  " If the file is new, then append the current date
  return filereadable(l:name)
		\ ? a:name
		\ : a:name . '_' . strftime('%Y%m%d')
endfunction

let g:wiki_root = '~/notes/mario/'
let g:wiki_cache_root = '~/.cache/wiki.vim/'
let g:wiki_link_extension = '.md'
let g:wiki_filetypes = ['md', 'wiki']

let g:wiki_map_create_page = 'FileFormat'

let g:wiki_map_link_create = 'LinkFormat'

function LinkFormat(text) abort
	return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction

" Disable Transform automatically to a links
let g:wiki_link_toggle_on_open = 0

function WikiToggleWiki(url, text) abort dict
  return wiki#link#md#template(a:url . '.wiki',
		\ empty(a:text) ? a:url : a:text)
endfunction

function WikiToggleMd(url, text) abort dict
  let l:url = substitute(a:url, '\.wiki$', '', '')
  return wiki#link#wiki#template(l:url, a:text)
endfunction
" TODO remove .md. when use wiki extension
let g:wiki_link_toggles = {
	  \ 'md': 'WikiToggleMd',
	  \ 'wiki': 'WikiToggleWiki',
	  \}
""" BINDING 
let g:wiki_mappings_use_defaults  = 'none'

""" Jornalling
" Probably use like w{weeknum}_year or year_w{weeknum}  try to consistent
" find best way to naming journaling weekly and monthly
"
let g:wiki_journal = {
	\ 'name': 'journal',
	\ 'frequency': 'daily',
	\ 'date_format': {
	\   'daily' : '%Y-%m-%d',
	\   'weekly' : '%Y_w%V',
	\   'monthly' : '%Y_m%m',
	\ },
	\}
" 
" Idk is undefined things woks, 
" Try to unmap some of the binding so it's not show up in whichkey
" mostly it bind to w
let g:wiki_mappings_global = {
	\ '<plug>(wiki-reload)' : '<leader>nx',
	\ '<plug>(wiki-graph-find-backlinks)' : 'null',
	\ '<plug>(wiki-link-toggle)' : 'Undefined',
	\ '<plug>(wiki-open)' : 'Undefined',
	\ '<plug>(wiki-export)' : 'Undefined',
	\}
" let g:wiki_viewer = {
" let g:wiki_file_open =
"
" let g:wiki_export = {
" 	\ 'args' : '',
" 	\ 'from_format' : 'markdown',
" 	\ 'ext' : 'pdf',
" 	\ 'link_ext_replace': v:false,
" 	\ 'view' : v:false,
" 	\ 'output': fnamemodify(tempname(), ':h'),
" 	\}
""""""""""""
" 	Vim-org mode
" let g:utl_cfg_hdl_scm_http_system = 'silent !xdg-open %u'
" let g:org_agenda_files = ['~/media/documents/org/gtd/*.org']
"
"
" Tempoarary
let g:taskwiki_suppress_mappings = "yes"
