local wk = require("whichkey_setup")
local local_keymap = {
	c = {
		name = '+code',
		o =  {':w <bar> !compiler %<CR>','compile'},
	}
}
wk.register_keymap('leader', local_keymap, {bufnr=0})
-- nnoremap <leader>cc :w <bar> !compiler %<CR>
-- function! OpenWith()
--     let curFile = substitute(bufname("%"), ".tex", ".pdf", "")
--     execute "silent !opout " curFile "&"
-- endfunction
--
-- nnoremap <leader>co :call OpenWith()<CR>
-- autocmd VimLeave *.tex !texclear %
--
