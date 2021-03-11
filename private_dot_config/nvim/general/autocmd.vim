" Ensure files are read as what I want:
autocmd BufRead,BufNewFile *.md,*.rmd,*.Rmd,*.txt set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
" When shortcut files are updated, renew bash and ranger configs with new material:
	autocmd BufWritePost bm-files,bm-dirs !shortcut
" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc,*.sxk !pkill -USR1 sxhkd;notify-send "Reload sxhkd Config"
" Recompile dwmblocks on config edit
	autocmd BufWritePost ~/.local/src/yadav-dwmblocks/config.h !cd ~/.local/src/yadav-dwmblocks/; sudo make clean install && { killall -q dwmblocks sigdwmblocks;setsid -f dwmblocks sigdwmblocks }
" Recompile dwm on config edit
	autocmd BufWritePost ~/.local/src/dwm/config.h !cd ~/.local/src/dwm/; sudo make clean install && prompt "Do you want to restart now" && {killall -q dwm dwmblocks sigdwmblocks; setsid -f dwmblocks sigdwmblocks}
" Enable Goyo by default for mutt writing
	" autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	" autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	" autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	" autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>
