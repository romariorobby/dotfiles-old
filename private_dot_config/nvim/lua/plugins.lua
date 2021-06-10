local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
	-- packer can manage itself
	use 'wbthomason/packer.nvim'
	-- {{GENERAL
    use 'romgrk/barbar.nvim' -- bar
	-- }}
	-- status line
    use 'glepnir/galaxyline.nvim'

	-- explorer
	use 'kyazdani42/nvim-tree.lua'

	-- Icons
    use {'yamatsum/nvim-web-nonicons', requires = {'kyazdani42/nvim-web-devicons'}}
    use 'ryanoasis/vim-devicons'

	-- Syntax Highlighting
	use 'romariorobby/vim-sxhkdrc'
	use 'norcalli/nvim-colorizer.lua'
	use 'sheerun/vim-polyglot'
	-- Live preview html
	use {'turbio/bracey.vim', run = {'npm install --prefix server'}}


	-- themes {{{
	-- use 'sainnhe/gruvbox-material'
	-- use 'morhetz/gruvbox'
	use 'christianchiarulli/nvcode-color-schemes.vim'
	use 'tjdevries/colorbuddy.vim'
	use 'tjdevries/gruvbuddy.nvim'
	-- Local Plugins {{
	use { "~/media/software/coloraqs" }
	-- }}}

	-- Which key
    use {'AckslD/nvim-whichkey-setup.lua', requires = 'liuchengxu/vim-which-key'}
	--

	-- Treesitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
	-- rainbow parantheses
	use 'p00f/nvim-ts-rainbow'
   use 'nvim-treesitter/playground'

	-- LSP Companion
	use 'neovim/nvim-lspconfig'
	use 'glepnir/lspsaga.nvim'
	use 'onsails/lspkind-nvim'
	use 'kabouzeid/nvim-lspinstall'
	-- Completions
		-- use 'nvim-lua/completion-nvim'
		use 'hrsh7th/nvim-compe'
	-- Auto Complete
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
		use "rafamadriz/friendly-snippets"
    use 'windwp/nvim-autopairs'
	-- misc
    use 'kosayoda/nvim-lightbulb'

	-- Tags based viewer
	use 'liuchengxu/vista.vim'
	-- Debugger
	use '/mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'
	-- Telescope
	use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
	use 'nvim-telescope/telescope-media-files.nvim'
	use 'nvim-telescope/telescope-packer.nvim'

	-- etc
	-- UTILS:
	-- GIT {{
		-- PR & Issue within vim
		-- use 'pwntester/octo.nvim'
		-- Git Message
		use 'rhysd/git-messenger.vim'
	-- Git sign
    if 0 == vim.fn.has 'nvim-0.5' then
		use 'mhinz/vim-signify'
    else
		use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}
    end
	use 'f-person/git-blame.nvim'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'tpope/vim-surround'

		-- }}
		-- Commenting
	use "terrortylor/nvim-comment"
		--
	use 'mbbill/undotree'
	-- TODO: Maybe will remove this by TrueZen plug
	use 'szw/vim-maximizer'
    use 'gennaro-tedesco/nvim-peekup' --  Still figure it out how to use this to my wf
		--
    use 'voldikss/vim-floaterm'
	use 'ptzz/lf.vim'
	-- use 'haorenW1025/floatLf-nvim'
	-- DOC:
		-- Markdown
    use {'npxbr/glow.nvim', run = ':GlowInstall'}
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm install'  }
    use 'ferrine/md-img-paste.vim'
	-- Zettelkasten {{ Make sure intalled neuron binary
	use 'oberblastmeister/neuron.nvim'
	-- }}
		-- org-mode?
	-- use 'jceb/vim-orgmode'
		-- {{ recommended plugins for org-mode
		use 'inkarkat/vim-SyntaxRange'
		use 'mattn/calendar-vim'
		use 'vim-scripts/utl.vim'
		-- use 'preservim/tagbar'
		-- }}
	-- use 'axvr/org.vim'
	use 'dhruvasagar/vim-dotoo'
	-- Roam {{
		--
	-- use 'lervag/wiki.vim'
	-- use 'lervag/wiki-ft.vim'
    -- use 'samgriesemer/wiki.vim'
	-- use 'samgriesemer/wiki.vim'
	--     use 'samgriesemer/vim-roam'
	-- use 'samgriesemer/vim-roam-md'
	-- use 'samgriesemer/vim-roam-task'
	-- use 'xarthurx/taskwarrior.vim'
	-- }}
		-- Inc and dec value
	-- use 'tpope/vim-speeddating'
   	-- use 'monaqa/dial.nvim'
		--
	use 'jbyuki/nabla.nvim'
	use 'akinsho/nvim-toggleterm.lua'
	--
	-- GODOT
	-- use 'habamax/vim-godot'
	use 'ThePrimeagen/vim-apm'

	-- Auto pairs
    -- use 'cohama/lexima.vim' -- Works i guess
	-- easy motion plugin like
	use 'phaazon/hop.nvim'
	use 'unblevable/quick-scope'

	-- Test new plug
    -- use 'andymass/vim-matchup'
	-- UI {{
		-- Motion Cursor  Highlight
		-- {{ I'm not sure i liked this but try for moment
		use {'edluffy/specs.nvim'}
		-- }}
		-- Zen Mode {{
		use 'junegunn/goyo.vim'
    	use 'junegunn/limelight.vim'
		-- In lua
		use "kdav5758/TrueZen.nvim"
		-- Dashboard kind of
		use 'mhinz/vim-startify'
		-- }}
	-- }}
	use 'MattesGroeger/vim-bookmarks'
	-- Better Quickfix
	use 'kevinhwang91/nvim-bqf'
	-- Emmet
    use 'mattn/emmet-vim'
	-- use 'tjdevries/complextras.nvim'
	-- Discord Presence
	-- use 'andweeb/presence.nvim'
	-- Collaborative Plugins
	-- use 'jbyuki/instant.nvim'
	-- FZF {{
	-- use {'junegunn/fzf', run = './install --all'}
	-- use {'junegunn/fzf.vim'}
	-- }}

end)
