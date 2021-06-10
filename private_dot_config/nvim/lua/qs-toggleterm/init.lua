require"toggleterm".setup{
  size = 10,
  open_mapping = [[<c-\>]],
  shade_filetypes = {"fzf"},
  shade_terminals = true,
  shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light0
  start_in_insert = true,
  persist_size = false,
  direction = 'horizontal',
}

-- TODO Make compiler executed to toggle term with current file
-- function _G.term_compile()
-- 	require('toggleterm').exec("compiler %", vim.v.count, 20)
-- end
-- vim.api.nvim_set_keymap("n", "<leader>z", [[<cmd>lua _G.term_compile()<CR>]], {silent = true, noremap = true})
