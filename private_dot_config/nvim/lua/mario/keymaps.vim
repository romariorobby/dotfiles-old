let mapleader = " "
let maplocalleader = " m"
let status = luaeval('require("mario.config")')
map <Space> <Nop>

com! W w
nnoremap Q <Nop>

" j/k to ESC
inoremap jk <ESC>
inoremap kj <ESC>
inoremap jj <ESC>
inoremap kk <ESC>

" Make arrow for scrolling
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
" Fun, freeze arrow :)
inoremap <Up>	<C-o>:echom "---> k <---"<CR>
inoremap <Down>	<C-o>:echom "---> j <---"<CR>
inoremap <Right>	<C-o>:echom "---> l <---"<CR>
inoremap <Left>	<C-o>:echom "---> h <---"<CR>

"
" Navigation
"
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
" Split
nnoremap <leader>s <C-w>s
nnoremap <leader>v <C-w>v

" Command Mode Navigation
cmap <C-h> <Left>
cmap <C-l> <Right>
cmap <C-k> <Up>
cmap <C-j> <Down>
cmap <C-D> <C-E><C-U>

nnoremap <leader>tl <cmd>lua qs.toggleline()<cr>
nnoremap <leader>tw <cmd>lua qs.togglewrap()<cr>

" Toggle Highlight
nnoremap <expr> <CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()


""
" Window
""
"" Resizing
" Horizontal
nnoremap <A-=> <C-W>+
nnoremap <A--> <C-W>-
" Vertical
nnoremap <A-,> <C-W><
nnoremap <A-.> <C-W>>
nnoremap <A-BS> <C-W>=

nnoremap <leader>wv <C-w>v
nnoremap <leader>ws <C-w>s
"Rotate upwards/leftwards
nnoremap <leader>wR <C-w>R

" Rotate downward/rightwards
nnoremap <leader>wr <C-w>r
"Swap/Exchange
nnoremap <leader>ww <C-w>x

"Move to far left
nnoremap <leader>wH <C-w>H

"Move to very bottom
nnoremap <leader>wJ <C-w>J

"Move to very top
nnoremap <leader>wK <C-w>K

"Move to far right
nnoremap <leader>wL <C-w>L

"Reset Window
nnoremap <leader>w0 <C-w>=

"Reset Window
nnoremap <leader>w<BS> <C-w>=

"Height: Decrease -1
nnoremap <leader>w- <C-w>-

"Height: Increase +1
nnoremap <leader>w= <C-w>+

"Height: Increase +5
nnoremap <leader>w+ <C-w>5+

"Height: Decrease -5
nnoremap <leader>w_ <C-w>5-

"Maximize: Horizontal
nnoremap <leader>w/ <C-w>_

"Maximize: Vertical
nnoremap <leader>w<bar> <C-w><bar>

"Width: Decrease -1
nnoremap <leader>w, <C-w><

"Width: Increase +1
nnoremap <leader>w. <C-w>>

"Width: Decreaes -5
nnoremap <leader>w< <C-w>5<

"Width: Increase +5
nnoremap <leader>w> <C-w>5>

"Move to new tab
nnoremap <leader>w<TAB> <C-w>T

"
" TAB
"

" Close Tab
nnoremap <leader><Tab>c <cmd>tabc<cr>
nnoremap <leader><Tab>d <cmd>tabc<cr>
" Close other tabs
nnoremap <leader><Tab>C <cmd>tabonly<cr>
" New
nnoremap <leader><Tab>a <cmd>tabnew<cr>
" Next
nnoremap <leader><Tab>l <cmd>tabn<cr>
" Previous
nnoremap <leader><Tab>h <cmd>tabp<cr>
" Next
nnoremap <leader><Tab>] <cmd>tabn<cr>
" Previous
nnoremap <leader><Tab>[ <cmd>tabp<cr>

""
"" Buffers
""
" Jump quicky alternate-file
nnoremap <A-Tab> <C-^>
nnoremap <leader>bx <cmd>lua require('mario.utils').close_buffer()<CR>
nnoremap <Tab> <cmd>bnext<cr>
nnoremap <S-Tab> <cmd>bprevious<cr>

" New Buffers
nnoremap <leader>bnn <cmd>split \| ene \| startinsert<cr>
nnoremap <leader>bns <cmd>split \| ene \| startinsert<cr>
nnoremap <leader>bnv <cmd>vsplit \| ene \| startinsert<cr>
" Delete
nnoremap <leader>bc <cmd>bdelete<cr>
nnoremap <leader>bd <cmd>bdelete<cr>
nnoremap <leader>bC <cmd>bwipeout<cr>

" Prev"
nnoremap <leader>bh <cmd>bprevious<cr>
nnoremap <leader>b[ <cmd>bprevious<cr>
" Next
nnoremap <leader>bl <cmd>bnext<cr>
nnoremap <leader>b] <cmd>bnext<cr>

nnoremap <leader>bg <cmd>bfirst<cr>
nnoremap <leader>bG <cmd>blast<cr>
nnoremap <leader>b$ <cmd>blast<cr>
nnoremap <leader>b0 <cmd>bfirst<cr>

" LSP
" TODO: Maps only in lsp active and on buffer
nnoremap <leader>cli <cmd>LspInfo<cr>
nnoremap <leader>cls <cmd>LspStart<cr>
nnoremap <leader>clS <cmd>LspStop<cr>
nnoremap <leader>clr <cmd>LspRestart<cr>


"
if (luaeval('qs.plugin_installed("telescope.nvim")') == 1 && status.telescope.main == 1)
	nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>
	nnoremap <leader>fp <cmd>lua require('plugins.telescope').find_neovim()<cr>
	nnoremap <leader>fF <cmd>Telescope live_grep theme=ivy<cr>
	nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
	nnoremap <leader>fb <cmd>lua require('plugins.telescope').find_buffers()<cr>
	nnoremap <leader>bf <cmd>lua require('plugins.telescope').find_buffers()<cr>
	nnoremap <leader>f. <cmd>lua require('plugins.telescope').find_dotfiles()<cr>
	nnoremap <leader>nf <cmd>lua require('plugins.telescope').find_notes()<cr>
	" Extensions
	if status.telescope.ext.project == 1
		nnoremap <leader>pp <cmd>Telescope projects<cr>
	endif
endif
if (luaeval('qs.plugin_installed("nvim-tree.lua")') == 1 && status.nvimtree == 1)
	nnoremap <leader>tn <cmd>NvimTreeToggle<cr>
endif

if executable("compiler") == 1
	nnoremap <localleader><C-x> <cmd>!compiler %<CR>
	nnoremap <localleader>X" <cmd>!compiler %<CR>
end

" fun! SetupPackerMap()
" 	augroup setup_packermap
" 		autocmd!
" 		nnoremap <buffer> <leader>ms <cmd>PackerSync<cr>
" 		nnoremap <buffer> <leader>mu <cmd>PackerUpdate<cr>
" 		set filetype=lua
" 	augroup end
" endfun

"if (luaeval('qs.plugin_installed("packer.nvim")') == 1
	" " exe "autocmd BufEnter " . g:pluginInit . " call SetupPackerMap()"
	" exe "autocmd BufEnter " g:pluginInit " call SetupPackerMap()"
" endif
