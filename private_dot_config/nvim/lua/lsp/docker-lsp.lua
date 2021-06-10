require'lspconfig'.dockerls.setup {
    cmd = {DATA_PATH .. "/lspinstall/dockerfile/node_modules/.bin/docker-langserver", "--stdio"},
    on_attach = COMPTACH,
	root_dir = vim.loop.cwd
}
