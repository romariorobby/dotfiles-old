local status_ok, config = pcall(require, "mario.config")
if not status_ok then
	return
end
local M = {}
local plugin_status = config.plugins

vim.g.mapleader = " " -- <Space>
vim.g.maplocalleader = " m" -- <Space>m
local fn = vim.fn
local nnoremap = qs.nnoremap
local inoremap = qs.inoremap
local vnoremap = qs.vnoremap
local xnoremap = qs.xnoremap
local tnoremap = qs.tnoremap
local cmap = qs.cmap
local nmap = qs.nmap
local map = qs.map
local name = qs.name

map("<F1>", "<Nop>") -- :help just enough
map("<Space>", "<Nop>")
-- Fun, freeze arrow :)
inoremap("<Up>", "<C-o>:echom '---> k <---'<CR>")
inoremap("<Down>", "<C-o>:echom '---> j <---'<CR>")
inoremap("<Right>", "<C-o>:echom '---> l <---'<CR>")
inoremap("<Left>", "<C-o>:echom '---> h <---'<CR>")

nnoremap(
	"<leader>fD",
	'<cmd>call delete(expand("%")) | echo "Deleted File" | bwipeout!<cr>',
	{ label = "Delete files" }
)
nmap("<leader>ao", 'viW"ay:!xdg-open <C-R>a &<CR><CR>', { silent = true, label = "Open with" })

-- Q to blackhole
nnoremap("Q", "<Nop>")

-- Toggle Highlight
nnoremap("<CR>", "{-> v:hlsearch ? ':nohl<CR>' : '<CR>'}()", { expr = true })

-- Indenting in visual block
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Move selected line / block of text in visual
vnoremap("K", ":move '<-2<CR>gv-gv")
vnoremap("J", ":move '>+1<CR>gv-gv")

--
nnoremap("<leader>ar", ":%s/<c-r><c-w>//g<left><left>", { label = "Substitute Under cursor" })

-- Command Mode Navigation
cmap("<C-h>", "<Left>")
cmap("<C-l>", "<Right>")
cmap("<C-k>", "<Up>")
cmap("<C-j>", "<Down>")
cmap("<C-D>", "<C-E><C-U>")

-- Norma mode Navigation
nnoremap("<leader>h", "<C-w>h", { label = "which_key_ignore" })
nnoremap("<leader>l", "<C-w>l", { label = "which_key_ignore" })
nnoremap("<leader>j", "<C-w>j", { label = "which_key_ignore" })
nnoremap("<leader>k", "<C-w>k", { label = "which_key_ignore" })

-- split window
nnoremap("<leader>s", "<C-w>s", { label = "which_key_ignore" })
nnoremap("<leader>v", "<C-w>v", { label = "which_key_ignore" })
nnoremap("<leader>ws", "<C-w>s", { label = "Horizontal split" })
nnoremap("<leader>wv", "<C-w>v", { label = "Vertical split" })

-- Buffer
nnoremap("<A-Tab>", "<C-^>") -- Switch between alternate file
nnoremap("<leader>bnn", "<cmd>split | ene | startinsert<cr>", { label = "New buffer" })
nnoremap("<leader>bns", "<cmd>split | ene | startinsert<cr>", { label = "New buffer split" })
nnoremap("<leader>bnv", "<cmd>vsplit | ene | startinsert<cr>", { label = "New buffer vsplit" })
if plugin_status.bufferline then
	nnoremap("<Tab>", "<cmd>BufferLineCycleNext<cr>")
	nnoremap("<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
	nnoremap("<leader>bf", "<cmd>BufferLinePick<cr>", { label = "Swith" })
	nnoremap("<leader>bc", "<cmd>BufferLinePickClose<cr>", {label = "Close"})
	nnoremap("<leader>bl", "<cmd>BufferLineCycleNext<cr>", {label = "Next"})
	nnoremap("<leader>bh", "<cmd>BufferLineCyclePrev<cr>", {label = "Previous"})
	nnoremap("<leader>b[", "<cmd>BufferLineCycleNext<cr>", {label = "Next"})
	nnoremap("<leader>b]", "<cmd>BufferLineCyclePrev<cr>", {label = "Previous"})
	nnoremap("<leader>bxh", "<cmd>BufferLineCloseLeft<cr>", {label = "Close all left"})
	nnoremap("<leader>bxl", "<cmd>BufferLineCloseRight<cr>", {label = "Close all right"})
	nnoremap("<leader>bk", "<cmd>BufferLineMoveNext<cr>", {label = "Move Next"})
	nnoremap("<leader>bj", "<cmd>BufferLineMovePrev<cr>", {label = "Move Prev"})
	nnoremap("<leader>bse", "<cmd>BufferLineSortByExtension<cr>", {label = "Extension/Language"})
	nnoremap("<leader>bsl", "<cmd>BufferLineSortByExtension<cr>", {label = "Extension/Language"})
	nnoremap("<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", {label = "Directory"})
	nnoremap({"<leader>b1", "<leader>b0"}, "<cmd>BufferLineGoToBuffer 1<cr>", {label = "Buffer 1"})
	nnoremap("<leader>b2", "<cmd>BufferLineGoToBuffer 2<cr>", {label = "Buffer 2"})
	nnoremap("<leader>b3", "<cmd>BufferLineGoToBuffer 3<cr>", {label = "Buffer 3"})
	nnoremap("<leader>b4", "<cmd>BufferLineGoToBuffer 4<cr>", {label = "Buffer 4"})
	nnoremap("<leader>b5", "<cmd>BufferLineGoToBuffer 5<cr>", {label = "Buffer 5"})
	nnoremap("<leader>b6", "<cmd>BufferLineGoToBuffer 6<cr>", {label = "Buffer 6"})
else
	nnoremap({ "<leader>bc", "<leader>bd" }, "<cmd>bdelete<cr>", { label = "Delete" })
	nnoremap("<leader>bC", "<cmd>bwipeout<cr>", { label = "Wipeout" })
	nnoremap({ "<S-Tab>", "<leader>bh", "<leader>b[" }, "<cmd>bprevious<cr>", { label = "Previous" })
	nnoremap({ "<Tab>", "<leader>bl", "<leader>b]" }, "<cmd>bnext<cr>", { label = "Next" })
	nnoremap({ "<leader>bg", "<leader>b0" }, "<cmd>bfirst<cr>", { label = "First Buffer" })
	nnoremap("<leader>bG", "<cmd>blast<cr>", { label = "Last Buffer" })
end
--
-- Window
nnoremap("<leader>wR", "<C-w>R", { label = "Rotate upward" }) --Rotate upwards/leftwards
nnoremap("<leader>wr", "<C-w>r", { label = "Rotate downward" }) -- Rotate downward/rightwards
nnoremap("<leader>ww", "<C-w>x", { label = "Swap" }) --Swap/Exchange
nnoremap("<leader>wH", "<C-w>H", { label = "Move to farthest left" }) --Move to far left
nnoremap("<leader>wJ", "<C-w>J", { label = "Move to farthest bottom" }) --Move to very bottom
nnoremap("<leader>wK", "<C-w>K", { label = "Move to farthest top" }) --Move to very top
nnoremap("<leader>wL", "<C-w>L", { label = "Move to farthest right" }) --Move to far right
-- gotta type it fast due conflict with whichkey <BS> for back. TODO: map whichkey <BS> for back
nnoremap({ "<A-BS>", "<leader>w0", "<leader>w<BS>" }, "<C-w>=", { label = "Reset" }) --Reset Window

nnoremap({ "<leader>w-", "<A-->" }, "<C-w>-", { label = "Height: Decrease -1" }) --Height: Decrease -1
nnoremap({ "<leader>w=", "<A-=>" }, "<C-w>+", { label = "Height: Increase +1" }) --Height: Increase +1

nnoremap({ "<leader>w,", "<A-,>" }, "<C-w><", { label = "Width: Decrease -1" }) --Width: Decrease -1
nnoremap({ "<leader>w.", "<A-.>" }, "<C-w>>", { label = "Width: Increase +1" }) --Width: Increase +1

nnoremap("<leader>w+", "<C-w>5+", { label = "Height: Increase +5" }) --Height: Increase +5
nnoremap("<leader>w_", "<C-w>5-", { label = "Height: Decrease -5" }) --Height: Decrease -5

nnoremap("<leader>w<", "<C-w>5<", { label = "Width: Decrease -5" }) --Width: Decreaes -5
nnoremap("<leader>w>", "<C-w>5>", { label = "Width: Increase +5" }) --Width: Increase +5

nnoremap("<leader>w/", "<C-w>_", { label = "Maximize: Horizontal" }) --Maximize: Horizontal
nnoremap("<leader>w<bar>", "<C-w><bar>", { label = "Maximize: Vertical" }) --Maximize: Vertical
nnoremap("<leader>wf", "<C-w>_", { label = "Maximize: Horizontal" }) --Maximize: Horizontal
nnoremap("<leader>wF", "<C-w><bar>", { label = "Maximize: Vertical" }) --Maximize: Vertical
nnoremap("<leader>w<TAB>", "<C-w>T", { label = "Move this file to new tab" }) --Move to new tab

---
--- TAB
---
nnoremap("<leader><Tab>c", "<cmd>tabc<cr>", { label = "Close Tab" })
nnoremap("<leader><Tab>d", "<cmd>tabc<cr>", { label = "Close Tab" })
nnoremap("<leader><Tab>C", "<cmd>tabonly<cr>", { label = "Close other tabs" })
nnoremap("<leader><Tab>a", "<cmd>tabnew<cr>", { label = "New" })
nnoremap("<leader><Tab>l", "<cmd>tabn<cr>", { label = "Next" })
nnoremap("<leader><Tab>h", "<cmd>tabp<cr>", { label = "Previous" })
nnoremap("<leader><Tab>]", "<cmd>tabn<cr>", { label = "Next" })
nnoremap("<leader><Tab>[", "<cmd>tabp<cr>", { label = "Previous" })

-- TODO: Only mapping this in certain buffer and filetype
if fn.executable("compiler") == 1 then
	nnoremap({ "<localleader><C-x>", "<localleader>X" }, "<cmd>!compiler %<CR>", { label = "Compile with compiler" })
	nnoremap("<localleader>s", "<cmd>lua _COMPILER_TOGGLE()<CR>", { label = "Compile with compiler" })
end

if plugin_status.nvimtree then
	nnoremap("<leader>tn", "<cmd>NvimTreeToggle<cr>", { label = "Explorer" })
end

if plugin_status.telescope.main then
	nnoremap("<leader>fn", "<cmd>lua require('plugins.telescope').find_neovim()<cr>", { label = "Neovim Dir" })
	nnoremap(
		"<leader>ff",
		"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		{ label = "Find Files" }
	)
	nnoremap("<leader>b/", "<cmd>lua require('plugins.telescope').find_buffers()<cr>", { label = "Buffer" })
	nnoremap("<leader>fg", "<cmd>lua require('plugins.telescope').grep_prompt()<cr>", { label = "Grep prompt" })
	nnoremap("<leader>fr", "<cmd>Telescope oldfiles<cr>", { label = "Recent files" })
	nnoremap("<leader>fF", "<cmd>Telescope live_grep theme=ivy<cr>", { label = "Live search" })
	nnoremap("<leader>f.", "<cmd>lua require('plugins.telescope').find_dotfiles()<cr>", { label = "Dotfiles" })
	nnoremap("<leader>Ht", "<cmd>Telescope colorscheme theme=dropdown<cr>", { label = "Themes" })
	nnoremap("<leader>H?", "<cmd>Telescope commands theme=ivy<cr>", { label = "Commands" })
	nnoremap("<leader>Ho", "<cmd>Telescope vim_options theme=ivy<cr>", { label = "Vim options/settings" })
	nnoremap("<leader>Hk", "<cmd>Telescope keymaps theme=ivy<cr>", { label = "Keymaps" })
	nnoremap("<leader>nf", "<cmd>lua require('plugins.telescope').find_notes()<cr>", { label = "Notes" })
	if plugin_status.telescope.ext.project then
		nnoremap("<leader>fpp", "<cmd>Telescope projects<cr>", { label = "Switch Projects" })
	end
	if plugin_status.telescope.ext.file_browser then
		nnoremap(
			"<leader>fb",
			"<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
			{ label = "File Browser" }
		)
	end
	if plugin_status.telescope.ext.media_files then
		nnoremap("<leader>fm", "<cmd>Telescope media_files<CR>", { label = "Media Files" })
	end
end
--
nnoremap("<leader>tl", "<cmd>lua qs.toggleline()<cr>", { label = "Line" })
nnoremap("<leader>tw", "<cmd>lua qs.togglewrap()<cr>", { label = "Wrap" })
if plugin_status.indentblankline then
	function IndentToggle()
		local opt = vim.opt
		vim.cmd([[IndentBlanklineToggle]])
		local list = opt.list:get()
		if list == true then
			opt.list = false
		else
			opt.list = true
		end
	end
	nnoremap("<leader>ti", "<cmd>lua IndentToggle()<cr>", { label = "Indent" })
end

if plugin_status.colorizer then
	nnoremap("<leader>tc", "<cmd>ColorizerToggle<cr>", { label = "Colorizer" })
end

if plugin_status.outline then
	nnoremap({ "<leader>to", "<leader>co" }, "<cmd>SymbolsOutline<cr>", { label = "Outline" })
end

if plugin_status.treesitter.main then
	if plugin_status.treesitter.ext.playground then
		nnoremap("<leader>ts", "<cmd>TSPlaygroundToggle<cr>", { label = "Playground" })
	end
end

if plugin_status.orgmode then
	name("<leader>na", { label = "Org: Agenda" })
	name("<leader>nc", "Org: Capture")
end

if plugin_status.git.gitsigns then
	name("<leader>gt", "Toggle")
	nnoremap({ "<leader>tgs", "<leader>gts" }, "<cmd>Gitsigns toggle_signs<cr>", { label = "signs" })
	nnoremap("<leader>gtn", "<cmd>Gitsigns toggle_numhl<cr>", { label = "numhl" })
	nnoremap("<leader>gtl", "<cmd>Gitsigns toggle_linehl<cr>", { label = "linehl" })
	nnoremap("<leader>gtw", "<cmd>Gitsigns toggle_word_diff<cr>", { label = "Word diff" })
	nnoremap("<leader>gb", "<cmd>Gitsigns blame_line<cr>", { label = "Blame" })
	nnoremap("<leader>gD", "<cmd>Gitsigns diffthis<cr>", { label = "Diff this" })
	-- nnoremap("<leader>gB", "<cmd>Gitsigns blame_line<cr>", )
	nnoremap("<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", { label = "Undo stage Hunk" })
	nnoremap("<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { label = "Reset Buffer" })
	nnoremap("<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", { label = "Reset Hunk" })
	nnoremap({ "<leader>gj", "]g" }, "<cmd>Gitsigns next_hunk<cr>", { label = "Next Hunk" })
	nnoremap({ "<leader>gk", "[g" }, "<cmd>Gitsigns prev_hunk<cr>", { label = "Previous Hunk" })
	nnoremap(
		"<leader>g]",
		"&diff ? '<leader>g]' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
		{ label = "Next Hunk" },
		{ expr = true }
	)
	nnoremap(
		"<leader>g[",
		"&diff ? '<leader>g[' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
		{ label = "Previous Hunk" },
		{ expr = true }
	)
end

vim.cmd([[
	autocmd FileType sh lua qs.nnoremap("<leader>fXc", "<cmd>silent !chmod +x %<CR>")
]])
-- Ledger
nnoremap("<leader>nl", ":!make -C $LEDGER_DIR ", { label = "Ledger make expand.." })
nnoremap({ "<leader>fS", "<leader>aS" }, "<cmd>source %<cr>", { label = "Source this file" })

-- Test
-- Copy to system clipboard
vnoremap("<C-c>", '"+y')
xnoremap("<leader>v", '"_dP')
-- Paste from system clipboard
inoremap("<C-v>", '<Esc>"+p')

if plugin_status.lsp.main then
	-- LSP
	name("<leader>cl", { label = "Lsp" })
	nnoremap("<leader>cli", "<cmd>LspInfo<cr>", { label = "Lsp Info" })
	nnoremap("<leader>cln", "<cmd>NullLsInfo<cr>", { label = "Null-ls Info" })
	nnoremap("<leader>cls", "<cmd>LspStart<cr>", { label = "Lsp Start" })
	nnoremap("<leader>clS", "<cmd>LspStop<cr>", { label = "Lsp Stop" })
	nnoremap("<leader>clr", "<cmd>LspRestart<cr>", { label = "Lsp Restart" })
	if plugin_status.lsp.ext.installer then
		nnoremap("<leader>clI", "<cmd>LspInstallInfo<cr>", { label = "Lsp install info" })
	end
end

-- LSP
M.lsp_keymaps = function(bufnr)
	-- nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {buffer = bufnr, label = "Declaration"})
	-- nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {buffer = bufnr})
	nnoremap(
		{ "gl", "<leader>cdl" },
		'<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
		{ buffer = bufnr }
	)
	nnoremap("gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = bufnr, label = "" })
	nnoremap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = bufnr })
	nnoremap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = bufnr })
	nnoremap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { buffer = bufnr, label = "Previous Diagnostics" })
	nnoremap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { buffer = bufnr, label = "Next Diagnostics" })
	nnoremap("<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = bufnr, label = "Implementation" })
	nnoremap(
		"<leader>cwa",
		"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
		{ buffer = bufnr, label = "Add Workspaces" }
	)
	nnoremap(
		"<leader>cwr",
		"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
		{ buffer = bufnr, label = "Remove workspaces" }
	)
	nnoremap(
		"<leader>cwl",
		"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		{ buffer = bufnr, label = "List workspaces" }
	)
	nnoremap(
		{ "<leader>cd", "gd" },
		"<cmd>lua vim.lsp.buf.type_definition()<CR>",
		{ buffer = bufnr, label = "Definitions" }
	)
	nnoremap(
		{ "<leader>cD", "gD" },
		"<cmd>lua vim.lsp.buf.declaration()<CR>",
		{ buffer = bufnr, label = "Declaration" }
	)
	if plugin_status.lsp.ext.saga then
		nnoremap("<leader>cr", "<cmd>Lspsaga rename<cr>", { buffer = bufnr, label = "Rename" })
	else
		nnoremap("<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = bufnr, label = "Rename" })
	end
	nnoremap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = bufnr, label = "Code Actions" })
	nnoremap(
		"<leader>ce",
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		{ buffer = bufnr, label = "Diagnostics: Floating" }
	)
	nnoremap(
		"<leader>cq",
		"<cmd>lua vim.diagnostic.setloclist()<CR>",
		{ buffer = bufnr, label = "Diagnostics: Setloclist" }
	)
	nnoremap("<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = bufnr, label = "Formatting" })
	vim.cmd([[com! Format execute 'lua vim.lsp.buf.formatting()']])
	-- Autoformat when save file
	-- vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
end
if plugin_status.hop then
	-- See if this this conflict or not with vim surround
	nnoremap('s', ":HopChar2<cr>")
	-- nnoremap('n', 's', ":HopWord<cr>", {silent = true})
	-- if theres a conflict use this binding
	-- vim.api.nvim_set_keymap('n', '<localleader>s', ":HopChar2<cr>", {silent = true})
	-- vim.api.nvim_set_keymap('n', '<localleader>s', ":HopWord<cr>", {silent = true})
end
if plugin_status.toggleterm then
	name("<leader>tt", { label = "Terminal" })
	nnoremap("<leader>ttt", "<cmd>ToggleTerm<CR>", { label = "Terminal" })
	nnoremap("<leader>ttl", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { label = "Lazygit" })
	nnoremap("<leader>tth", "<cmd>lua _HTOP_TOGGLE()<CR>", { label = "Htop" })
end

M.md_keymaps = function()
	if plugin_status.glow then
		nnoremap("<LocalLeader>g", "<cmd>Glow<cr>", { buffer = 0, label = "Glow" })
	end
	if plugin_status.markdownpreview then
		nnoremap("<LocalLeader>m", "<cmd>MarkdownPreviewToggle<cr>", { buffer = 0, label = "Markdown Preview" })
	end
end

M.term_keymaps = function()
	-- local opts = {noremap = true}
	-- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', 'q', [[<C-\><C-n>]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', '<leader>h', [[<C-\><C-n><C-W>h]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', '<leader>j', [[<C-\><C-n><C-W>j]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', '<leader>k', [[<C-\><C-n><C-W>k]], opts)
	-- vim.api.nvim_buf_set_keymap(0, 't', '<leader>l', [[<C-\><C-n><C-W>l]], opts)
	tnoremap("<esc>", [[<C-\><C-n>]], { buffer = 0 })
	tnoremap("<leader>h", [[<C-\><C-n><C-w>h]], { buffer = 0 })
	tnoremap("<leader>j", [[<C-\><C-n><C-w>j]], { buffer = 0 })
	tnoremap("<leader>k", [[<C-\><C-n><C-w>k]], { buffer = 0 })
	tnoremap("<leader>l", [[<C-\><C-n><C-w>l]], { buffer = 0 })
	tnoremap("<leader><TAB>h", [[<C-\><C-n><cmd>tabp<cr>]], { buffer = 0 })
	tnoremap("<leader><TAB>l", [[<C-\><C-n><cmd>tabn<cr>]], { buffer = 0 })
end
return M
