-- See if this this conflict or not with vim surround
vim.api.nvim_set_keymap('n', 's', ":HopChar2<cr>", {silent = true})
vim.api.nvim_set_keymap('n', 's', ":HopWord<cr>", {silent = true})
-- if theres a conflict use this binding
-- vim.api.nvim_set_keymap('n', '<localleader>s', ":HopChar2<cr>", {silent = true})
-- vim.api.nvim_set_keymap('n', '<localleader>s', ":HopWord<cr>", {silent = true})
