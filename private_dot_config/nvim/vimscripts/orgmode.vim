" let g:org_export_emacs="/usr/bin/emacs"
"
" DOTOO
" let g:dotoo#agenda#files = ["~/media/documents/notes/gtd/*.org", "~/media/documents/notes/roam/private/*.org"]
" let g:dotoo_todo_keyword_faces = [
" 	\ ['TODO', [':foreground 160', ':weight bold']],
" 	\ ['NEXT', [':foreground 27', ':weight bold']],
" 	\ ['WAITING', [':foreground 202', ':weight bold']],
" 	\ ['DONE', [':foreground 22', ':weight bold']],
" 	\ ['CANCELLED', [':foreground 22', ':weight bold']],
" 	\ ]
" 
" 
" let g:dotoo_headline_highlight_colors = [
"   \ 'Title',
"   \ 'Constant',
"   \ 'Identifier',
"   \ 'Statement',
"   \ 'PreProc',
"   \ 'Type',
"   \ 'Special']

" ORG MODE
" let g:org_todo_keywords = [['TODO(t)', "PROJ(p)", "NEXT(n)", '|', 'DONE(d)'],
"       \ ['WAITING(w)', 'HOLD(h)', '|', 'CANCELLED(c)']]
" let g:org_agenda_files = ['~/Dropbox/media/documents/gtd/projects.org']
" 
" let g:org_todo_keyword_faces = [['NEXT', 'cyan']]

let g:dotoo#agenda#files = ['~/Dropbox/media/documents/notes/gtd/*.org']
" Blocks Source"
let g:dotoo_begin_src_languages = ['vim', 'json', 'javascript', 'c', 'python']
" Refile File"
let g:dotoo#capture#refile = expand('~/Dropbox/media/documents/notes/gtd/inbox.org.')
