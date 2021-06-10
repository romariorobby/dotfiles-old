require'lspconfig'.texlab.setup{
    cmd =  {DATA_PATH .. "/lspinstall/latex/texlab"},
    on_attach = COMPTACH
}
