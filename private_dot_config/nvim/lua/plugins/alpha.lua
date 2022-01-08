local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local default_header = {
	type = "text",
	val = {
	[[    .--------------.    ]],
	[[    |.------------.|    ]],
	[[    ||$nvim       ||    ]],
	[[    ||            ||    ]],
	[[    ||            ||    ]],
	[[    |'------------'|    ]],
	[[ .--^------^^------^--. ]],
	[[ | ----~       *nix   | ]],
	[[ "--------------------' ]],
	},
	opts = {
		position = "center",
		hl = "Type",
		-- wrap = "overflow";
	},
}
local function fPlugins()
	local plugins_loaded = #vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1)
	local total_plugins = #vim.tbl_keys(packer_plugins)
	local datetime = os.date(" %d-%m-%Y  %H:%M:%S")
	return "┌─ ﯁ "
		.. plugins_loaded
		.. " (loaded)   \n"
		.. "└─  "
		.. total_plugins
		.. " (installed)\n"
		.. datetime
end
local plugins_loaded = #vim.fn.globpath(vim.fn.stdpath("data") .. "/site/pack/packer/start", "*", 0, 1)
local total_plugins = #vim.tbl_keys(packer_plugins)

local sub_header = {
	type = "text",
	val = "",
	opts = {
		position = "center",
		hl = "Type",
	},
}

local plugins = {
	type = "text",
	val = " ﯁ " .. plugins_loaded .. " loaded" .. " │ " .. " " .. total_plugins .. " installed",
	opts = {
		position = "center",
		hl = "Type",
	},
}

local footer = {
	type = "text",
	val = "aQs",
	opts = {
		position = "center",
		hl = "text",
	},
}

--- @param sc string
--- @param txt string
--- @param keybind string optional
local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
		-- hl = "AlphaButtons",
	}
	if keybind then
		opts.keymap = { "n", sc_, keybind, {noremap = true, silent = true, nowait = true}}
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
		button("n", "ﱐ  New file", "<cmd>ene <CR>"),
    button("p", "  Find Project", "<cmd>Telescope projects<CR>"),
    button("r", "  Recent files"   , ":Telescope oldfiles<CR>"),
    button("u", "  Update plugins"   , ":PackerUpdate<CR>"),
    button("f", "  Find files", ":cd $HOME | Telescope find_files<CR>"),
    button("i", "  Init", ":e $MYVIMRC | :cd %:p:h | split . | pwd | NvimTreeToggle<CR>"),
    button("q", "  Quit", ":qa<CR>"),
	},
	opts = {
		spacing = 1,
	},
}

local section = {
	header = default_header,
	sub_header = sub_header,
	buttons = buttons,
	plugins = plugins,
	footer = footer,
}

local opts = {
	layout = {
		{ type = "padding", val = 2 },
		section.header,
		{ type = "padding", val = 1 },
		section.buttons,
		section.plugins,
		{ type = "padding", val = 2 },
		-- section.footer,
	},
	opts = {
		margin = 5,
	},
}
alpha.setup(opts)
