" idk how to do these in lua
" Ensure files are read as what I want:
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
autocmd BufRead,BufNewFile *.md,*.rmd,*.Rmd,*.txt set filetype=markdown
" autocmd BufRead,BufNewFile *.org set filetype=dotoo
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufWinEnter,WinEnter term://* :set rnu!
autocmd! BufRead,BufNewFile *.org setlocal filetype=dotoo
" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcut
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults,xresources !xrdb %
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc,*.sxk !pkill -USR1 sxhkd;notify-send "Reload sxhkd Config"
" Source file vim or lua
	" autocmd BufWritePost *.vim :source %
	" autocmd BufWritePost *.lua :luafile %
	" Automaticlyy packersync
	" autocmd BufWritePost ~/.config/nvim/lua/plugins.lua :PackerSync
" Recompile dwmblocks on config edit
	autocmd BufWritePost ~/.local/src/yadav-dwmblocks/config.h !cd ~/.local/src/yadav-dwmblocks/; sudo make clean install && { killall -q dwmblocks sigdwmblocks;setsid -f dwmblocks sigdwmblocks }
" Recompile dwm on config edit
	autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/; sudo make clean install && prompt "Do you want to restart now" && {killall -q dwm dwmblocks sigdwmblocks; setsid -f dwmblocks sigdwmblocks}
" Enable Goyo by default for mutt writing
	" autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	" autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	" autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	" autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'media/image'
let g:mdip_imgname = 'image'

autocmd FileType lspinfo nnoremap <silent> <buffer> q :q<CR>
autocmd FileType floaterm nnoremap <silent> <buffer> q :q<CR>

" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set rnu nu
"   autocmd BufLeave,FocusLost,InsertEnter   * set relativenumber!
" augroup END

" Clears hlsearch after doing a search, otherwise just does normal <CR> stuff
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()

"   Auto places you into the spot where you can start typing to change it.
nnoremap <c-w><c-r> :%s/<c-r><c-w>//g<left><left>

" Fun, freeze arrow :)
inoremap <Up>     <C-o>:echom "--> k <-- "<CR>
inoremap <Down>   <C-o>:echom "--> j <-- "<CR>
inoremap <Right>  <C-o>:echom "--> l <-- "<CR>
inoremap <Left>   <C-o>:echom "--> h <-- "<CR>
