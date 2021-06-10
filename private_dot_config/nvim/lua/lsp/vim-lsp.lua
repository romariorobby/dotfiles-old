require'lspconfig'.vimls.setup {
    cmd = { DATA_PATH  .. "/lspinstall/vim/node_modules/.bin/vim-language-server", "--stdio"},
    on_attach = COMPTACH
}
