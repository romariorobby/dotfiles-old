vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_tree_follow = 1
vim.g.nvim_tree_hide_dotfiles = 1 --0 by default, this option hides files and folders starting with a dot `.`
vim.g.nvim_tree_auto_close = 0 --0 by default, closes the tree when it's the last window
-- Mapping
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
    ["<CR>"]           = tree_cb("edit"),
    ["x"]              = tree_cb("cut"),
    ["c"]              = tree_cb("copy"),
    ["p"]              = tree_cb("paste"),
    ["o"]              = tree_cb("edit"),
    ["."]              = tree_cb("toggle_dotfiles"),
    ["<2-LeftMouse>"]  = tree_cb("edit"),
    ["<2-RightMouse>"] = tree_cb("cd"),
    ["rA"]             = tree_cb("rename"),
    ["rc"]          	 = tree_cb("full_rename"),
    ["L"]          = tree_cb("cd"),
    ["H"]              = tree_cb("dir_up"),
    ["v"]          = tree_cb("vsplit"),
    ["s"]          = tree_cb("split"),
    ["<C-t>"]          = tree_cb("tabnew"),
    ["<BS>"]           = tree_cb("close_node"),
    ["<S-CR>"]         = tree_cb("close_node"),
    ["<Tab>"]          = tree_cb("preview"),
    ["I"]              = tree_cb("toggle_ignored"),
    ["R"]              = tree_cb("refresh"),
    ["a"]              = tree_cb("create"),
    ["d"]              = tree_cb("remove"),
    ["[c"]             = tree_cb("prev_git_item"),
    ["]c"]             = tree_cb("next_git_item"),
    ["q"]              = tree_cb("close"),

}
vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = "✗",
      staged = "✓",
      unmerge = "",
      renamed = "",
      untracked = ""
    },
    folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
      symlink_open = "",
      }
    }
