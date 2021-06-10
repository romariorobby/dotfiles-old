require'lspconfig'.intelephense.setup {
    cmd = { DATA_PATH .. "/lspinstall/php/node_modules/.bin/intelephense", "--stdio" },
	filetypes = { "php" },
    on_attach = COMPTACH
}
