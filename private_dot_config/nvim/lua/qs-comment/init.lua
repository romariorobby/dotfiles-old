require('nvim_comment').setup()
vim.api.nvim_set_keymap('n', "<leader>//", ":CommentToggle<CR>", {noremap=true, silent=true})
-- vim.api.nvim_set_keymap('i', "<leader>/", ":CommentToggle<CR>", {noremap=true})
vim.api.nvim_set_keymap('v', "<leader>//", ":CommentToggle<CR>", {noremap=true, silent=true})
