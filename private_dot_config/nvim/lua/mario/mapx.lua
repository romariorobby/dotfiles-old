-- Removed soon: testing purposes
require'mapx'.setup { global = true, whichkey = true}

vim.g.mapleader = " "       -- <Space>
vim.g.maplocalleader = "\\" -- <Space>m
nnoremap("<leader>fz", ':echom "---> Mapx-test (SPC . fz) <---"<CR>', { label = "[Mapx-test] Hello", ft = "lua" })
nname("<leader>w", "Windows")
nnoremap("Q", "<Nop>")
