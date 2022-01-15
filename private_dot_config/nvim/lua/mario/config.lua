-- Enble/Disable Plugins
return {
	plugins = {
		keymap = false,
		telescope = {
			main = true,
			ext = {
				project = true,
				media_files = true,
				file_browser = true,
			},
		},
		hop = true,
		bracey = false,
		numb = true,
		peekup = false,
		quickscope = false,
		todocomments = true,
		trouble = true,
		indentblankline = true,
		vim_repeat = true,
		autopairs = true,
		bufferline = true,
		outline = true,
		surround = {
			vim_surround = true,
			sandwich = false,
			nvim_surround = {
				main = false,
				style = "surround", -- or "sandwich"
			},
		},
		-- Completion
		nvim_cmp = {
			main = true,
			ext = {
				lsp = true,
				lua = true,
				buf = true,
				path = true,
				cmd = true,
				luasnip = true,
			},
		},
		icons = {
			devicons = true,
			nonicons = true,
		},
		lsp = {
			main = true,
			ext = {
				installer = true,
				saga = true,
			},
		},
		null_ls = true,
		colorizer = true,
		treesitter = {
			main = true,
			ext = {
				context_commentstring = true,
				playground = true,
				rainbow = true,
			},
		},
		alpha = true,
		whichkey = true,
		-- Snippets
		luasnip = true,
		friendly_snip = true,

		comment = true,
		lualine = true,
		nvimtree = true,
		git = {
			gitlinker = true,
			gitsigns = true,
			neogit = false,
		},
		toggleterm = true,

		-- Document
		vimwiki = false,
		orgmode = true,
		neorg = true,
		vimledger = true,
		-- Md
		glow = true,
		markdownpreview = true,
	},
}
