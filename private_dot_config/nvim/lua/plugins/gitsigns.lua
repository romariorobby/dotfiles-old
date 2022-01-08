local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
	return
end

gitsigns.setup({
	signs = {
		add = {
			hl = "GitSignsAdd",
			text = "▎+",
			numhl = "GitSignsAddNr",
			linehl = "GitSignsAddLn",
		},
		change = {
			hl = "GitSignsChange",
			text = "▎!",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
		delete = {
			hl = "GitSignsDelete",
			text = "契",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		topdelete = {
			hl = "GitSignsDelete",
			text = "契",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		changedelete = {
			hl = "GitSignsChange",
			text = "▎!",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
	},
	watch_index = {
		interval = 1000,
	},
	numhl = false,
	linehl = false,
	sign_priority = 6,
	update_debounce = 200,
	status_formatter = nil, -- Use default
	keymaps = {
		noremap = true,
		buffer = true,
		-- Default keymap options
		-- ["n <leader>g]"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
		-- ["n <leader>g["] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
		-- ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		-- ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		-- ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		-- ['n <leader>gR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		-- ['n <leader>gh'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		-- ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
	},
})
