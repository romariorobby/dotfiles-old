local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<C-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

vim.cmd('autocmd! TermOpen term://* lua require("mario.keymaps").term_keymaps()')

local term = require("toggleterm.terminal").Terminal
local lazygit = term:new({ cmd = "lazygit", hidden = true })
local python = term:new({ cmd = "python", hidden = true })
local htop = term:new({ cmd = "htop", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

function _PYTHON_TOGGLE()
	python:toggle()
end

function _HTOP_TOGGLE()
	htop:toggle()
end
