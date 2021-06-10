-- If you are using rvm, make sure to change below configuration
require'lspconfig'.solargraph.setup {
    cmd = { DATA_PATH .. "/lspinstall/ruby/solargraph/bin/solargraph", "--stdio" },
    on_attach = COMPTACH,
    filetypes = { "ruby" }
}
