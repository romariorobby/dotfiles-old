local status_ok, packer = pcall(require, "plugins.packerInit")
local plug_builtin = pcall(require, "plugins.plugs-builtin")
if not plug_builtin then
	print("Disable builtin plugins not detected")
	return false
end

if not status_ok then
	return false
end
local misc = require("mario.utils.misc")
local use = packer.use
-- local plugin_status = qs.loadconfig()
local plugin_status = require("mario.config").plugins

vim.cmd([[
	augroup config_sync
		autocmd!
		autocmd BufWritePost ~/.config/nvim/lua/mario/config.lua lua R("mario.config")
		autocmd BufWritePost ~/.config/nvim/lua/mario/config.lua lua R("plugins")
		autocmd BufWritePost ~/.config/nvim/lua/mario/config.lua lua R("mario.keymaps")
	 " How to reload in vimscript? if can't wait until neovim lua mapping and cmd bit consistent
	 " autocmd BufWritePost ~/.config/nvim/lua/mario/config.lua lua qs.source("lua/mario/keymaps.vim", true)
	 " autocmd BufWritePost ~/.config/nvim/lua/mario/config.lua source <afile> | PackerSync
   "autocmd BufWritePost ~/.config/nvim/lua/plugins/init.lua source <afile> | PackerSync
	augroup end
]])

-- Check connection
-- if qs.checkconnection() then
-- -- Autocommand to reload neovim when save plugin.lua file
-- 	vim.cmd[[
-- 		augroup packer_user_conf
-- 			autocmd!
-- 		" TODO: How to expand global variable to autocmd?
-- 		  autocmd BufWritePost ~/.config/nvim/lua/mario/config.lua source <afile> | PackerSync
-- 			autocmd BufWritePost ~/.config/nvim/lua/plugins/init.lua source <afile> | PackerSync
-- 		augroup end
-- 	]]
-- end
local commit = {
	orgmode = "159db459f4495802a98401952d9ff441919c0a4b",
}

return packer.startup(function()
	-- local
	use("~/repos/kanagawa.nvim")
	use("~/repos/tokyonight.nvim")
	use("~/repos/rogruv.nvim")
	--
	--	use { "romariorobby/nvcode-color-schemes.vim" }
	use("b0o/mapx.nvim")
	use({
		"wbthomason/packer.nvim",
		event = "VimEnter",
	})
	use("lewis6991/impatient.nvim")

	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })

	use({
		"norcalli/nvim-colorizer.lua",
		disable = not plugin_status.colorizer,
		event = "BufRead",
		config = function()
			require("plugins.colorizer")
		end,
	})

	use({
		"windwp/nvim-autopairs",
		disable = not plugin_status.autopairs,
		config = function()
			require("plugins.autopairs")
		end,
	})

	-- Repeat actions better
	use({
		"tpope/vim-repeat",
		disable = not plugin_status.vim_repeat,
	})
	-- Surround
	if plugin_status.surround.vim_surround == false and plugin_status.surround.sandwich == false then
		use({
			"blackCauldron7/surround.nvim",
			disable = not plugin_status.surround.nvim_surround.main,
			config = function()
				require("plugins.surround")
			end,
		})
	elseif plugin_status.surround.vim_surround then
		use({
			"tpope/vim-surround",
			disable = not plugin_status.surround.vim_surround,
		})
	else
		use({
			"machakann/vim-sandwich",
			disable = not plugin_status.surround.sandwich,
		})
	end

	use({
		"nvim-telescope/telescope.nvim",
		disable = not plugin_status.telescope.main,
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	})

	use({
		"nvim-telescope/telescope-file-browser.nvim",
		disable = not plugin_status.telescope.ext.file_browser,
	})

	if vim.g.os == "Linux" then
		use({
			"nvim-telescope/telescope-media-files.nvim",
			disable = not plugin_status.telescope.ext.media_files,
		})
	end

	use({
		"ahmedkhalf/project.nvim",
		after = "telescope.nvim",
		disable = not plugin_status.telescope.ext.project,
		config = function()
			require("plugins.project")
		end,
	})
	-- LSP
	use({
		"neovim/nvim-lspconfig",
		disable = not plugin_status.lsp.main,
		config = function()
			require("plugins.lspconfig")
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		disable = not plugin_status.null_ls,
		config = function()
			require("lsp.null-ls")
		end,
	})
	use({
		"simrat39/symbols-outline.nvim",
		disable = not plugin_status.outline,
		cmd = "SymbolsOutline",
		setup = function()
			vim.g.symbols_outline = {
				auto_preview = false,
				highlight_hovered_item = false,
				width = 10,
			}
		end,
	})
	use({
		"williamboman/nvim-lsp-installer", -- simple to use language server installer
		after = "nvim-lspconfig",
		disable = not plugin_status.lsp.ext.installer,
	})
	use({
		"glepnir/lspsaga.nvim",
		after = "nvim-lspconfig",
		disable = not plugin_status.lsp.ext.saga,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		disable = not plugin_status.treesitter.main,
		run = ":TSUpdate",
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
		disable = not plugin_status.treesitter.ext.rainbow,
	})

	use({
		"nvim-treesitter/playground",
		after = "nvim-treesitter",
		disable = not plugin_status.treesitter.ext.playground,
	})

	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		after = "nvim-treesitter",
		disable = not plugin_status.treesitter.ext.context_commentstring,
	})
	use({
		"akinsho/bufferline.nvim",
		disable = not plugin_status.bufferline,
		config = function()
			require("plugins.bufferline")
		end,
	})

	use({
		"kyazdani42/nvim-web-devicons",
		disable = not plugin_status.icons.devicons,
	})

	local has_nonicons = vim.fn.system({ "fc-list", "nonicons" })
	if has_nonicons ~= "" then
		if not plugin_status.icons.nonicons then
			print("nonicons found on the system")
			misc.warn("nvim-nonicons disabled")
		else
			use({
				"yamatsum/nvim-nonicons",
				disable = not plugin_status.icons.nonicons,
			})
		end
	else
		misc.warn("Nonicons not installed on this machine.\nhttps://github.com/yamatsum/nonicons")
	end

	use({
		"nvim-lualine/lualine.nvim",
		disable = not plugin_status.lualine,
		config = function()
			require("plugins.lualine")
		end,
	})

	use({
		"kyazdani42/nvim-tree.lua",
		disable = not plugin_status.nvimtree,
		config = function()
			require("plugins.nvimtree")
		end,
	})
	use({
		"numToStr/Comment.nvim",
		disable = not plugin_status.comment,
		config = function()
			require("Comment").setup()
			--			require('plugins.comment')
		end,
	})
	use({
		"folke/which-key.nvim",
		disable = not plugin_status.whichkey,
		event = "BufWinEnter",
		config = function()
			require("plugins.whichkey")
		end,
	})

	-- CMP
	use({
		"hrsh7th/nvim-cmp",
		disable = not plugin_status.nvim_cmp.main,
		config = function()
			require("plugins.cmp")
		end,
	})
	use({
		"hrsh7th/cmp-nvim-lsp",
		after = "nvim-cmp",
		disable = not plugin_status.nvim_cmp.ext.lsp,
	})
	use({
		"hrsh7th/cmp-nvim-lua",
		after = "nvim-cmp",
		disable = not plugin_status.nvim_cmp.ext.lua,
	})
	use({
		"hrsh7th/cmp-buffer",
		after = "nvim-cmp",
		disable = not plugin_status.nvim_cmp.ext.buf,
	})
	use({
		"hrsh7th/cmp-path",
		after = "nvim-cmp",
		disable = not plugin_status.nvim_cmp.ext.path,
	})
	use({
		"hrsh7th/cmp-cmdline",
		after = "nvim-cmp",
		disable = not plugin_status.nvim_cmp.ext.cmd,
	})

	-- Luasnip
	use({
		"L3MON4D3/LuaSnip",
		disable = not plugin_status.luasnip,
		config = function ()
			require("plugins.luasnip")
		end
	})
	use({
		"saadparwaiz1/cmp_luasnip", -- snippet completions
		disable = not plugin_status.nvim_cmp.ext.luasnip,
	})

	use({
		"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		disable = not plugin_status.friendly_snip,
	})

	-- Notes
	--

	use({
		"ellisonleao/glow.nvim",
		disable = not plugin_status.glow,
		config = function()
			vim.g.glow_use_pager = true
			vim.g.glow_style = "dark"
			vim.g.glow_border = "rounded"
			vim.g.glow_width = 240
		end,
	})
	use({
		"iamcco/markdown-preview.nvim",
		disable = not plugin_status.markdownpreview,
		run = "cd app && npm install",
	})

	use({
		"vimwiki/vimwiki",
		disable = not plugin_status.vimwiki,
		--		config = require("plugins.vimwiki").config,
		config = function()
			require("plugins.vimwiki")
		end,
	})
	use({
		"nvim-orgmode/orgmode",
		-- TODO: remove this when my neovim uses filetype.lua support
		commit = commit.orgmode,
		disable = not plugin_status.orgmode,
		config = function()
			require("plugins.orgmode")
		end,
	})

	use({
		"nvim-neorg/neorg",
		disable = not plugin_status.neorg,
		requires = {
			"nvim-neorg/neorg-telescope",
		},
		config = function()
			require("plugins.neorg")
		end,
	})

	use({
		"ledger/vim-ledger",
		disable = not plugin_status.vimledger,
	})

	-- Git
	use({
		"ruifm/gitlinker.nvim",
		disable = not plugin_status.git.gitlinker,
		config = function()
			require("plugins.gitlinker")
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		disable = not plugin_status.git.gitsigns,
		event = "BufRead",
		config = function()
			require("plugins.gitsigns")
		end,
	})

	use({
		"TimUntersberger/neogit",
		disable = not plugin_status.git.neogit,
	})

	use({
		"akinsho/toggleterm.nvim",
		disable = not plugin_status.toggleterm,
		config = function()
			require("plugins.toggleterm")
		end,
	})

	use({
		"folke/todo-comments.nvim",
		disable = not plugin_status.todocomments,
		config = function()
			require("plugins.todocomments")
		end,
	})
	use({
		"folke/trouble.nvim",
		disable = not plugin_status.trouble,
		config = function()
			require("plugins.trouble")
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		disable = not plugin_status.indentblankline,
		config = function()
			require("plugins.indentblankline")
		end,
	})
	use({
		"goolord/alpha-nvim",
		disable = not plugin_status.alpha,
		config = function()
			require("plugins.alpha")
		end,
	})
	use({
		"phaazon/hop.nvim",
		disable = not plugin_status.hop,
		config = function()
			require("plugins.hop")
		end,
	})
	use({
		"gennaro-tedesco/nvim-peekup",
		disable = not plugin_status.peekup,
	})
	use({
		"unblevable/quick-scope",
		disable = not plugin_status.quickscope,
	})
	use({
		"turbio/bracey.vim",
		disable = not plugin_status.bracey,
		run = {
			"npm install --prefix server",
		},
	})
	-- Peek Number
	use({
		"nacro90/numb.nvim",
		disable = not plugin_status.numb,
		config = function()
			require("numb").setup()
		end,
	})
	use({
		'~/repos/chezmoi.nvim',
		 config = function()
			 require"chezmoi".setup({
				 exec = "chezmoi",
			})
	end,
	})

	if packer.PACKER_BOOSTRAP then
		require("packer").sync()
	end
end)
