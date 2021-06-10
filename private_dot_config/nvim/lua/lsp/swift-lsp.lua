require'lspconfig'.sourcekit.setup{
    cmd = { "/usr/bin/sourcekit-lsp" },
    filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp" },
    root_dir = require('lspconfig/util').root_pattern("Package.swift"),
	on_attach = COMPTACH
}
