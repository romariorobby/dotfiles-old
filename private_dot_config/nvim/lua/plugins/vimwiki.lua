--local M = {}

-- function M.setup()
-- 	require('which-key').register({
-- 		["<leader>"] = {
-- 		n = {
-- 			name = "notes",
-- 			w = {
-- 				name = "wiki",
-- 				w = 'wiki: Index ',
-- 			},
-- 		},
-- 	},
-- })
 	vim.g.vimwiki_ext2syntax = {
 		[".Rmd"] = "markdown",
		[".md"] = "markdown",
	}

	vim.g.vimwiki_list = {
		{
			path = "~/Documents/mario",
			syntax = "markdown",
			ext = ".md",
		},
		{
			path = "~/Documents/mario/journals",
			syntax = "markdown",
			ext = ".md",
		},
		{
			path = "~/Documents/mario/pages",
			syntax = "markdown",
			ext = ".md",
		},
	}
-- end
-- function M.config()
-- 	require('which-key').register({
-- 		["<leader>"] = {
-- 		n = {
-- 			name = "notes",
-- 			w = {
-- 				name = "wiki",
-- 				w = 'wiki: Index ',
-- --				t = 'twiki: '
-- 			},
-- 		},
-- 	},
-- })
-- end
-- " VIMWIKI
-- " let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', 'markdown': '.md'}
-- let g:vimwiki_list = [
-- 			\{'path': '~/Documents/mario', 'syntax': 'markdown', 'ext': '.md'},
-- 			\{'path': '~/Documents/mario/journals', 'syntax': 'markdown', 'ext': '.md'},
-- 			\{'path': '~/Documents/mario/pages', 'syntax': 'markdown', 'ext': '.md'}]

-- return M
