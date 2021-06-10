require'lspconfig'.pyright.setup {
	cmd = {DATA_PATH .. "/lspinstall/python/node_modules/.bin/pyright-langserver", "--stdio"},
	filetypes= {"python"},
	on_attach = COMPTACH,
	handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
		})
	}
}

