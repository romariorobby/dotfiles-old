local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
	return
end

npairs.setup {
	check_ts = true,
	ts_config = {
			lua = {'string', 'source'},-- it will not add a pair on that treesitter node
			javascript = { 'string','template_string'},
			java = false,-- don't check treesitter on java
	},
	disabled_filetypes = { "TelescopePrompt" },
  fast_wrap = {
    map = "<C-\\>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
	},
}

local cmp_npairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_npairs.on_confirm_done { map_char = { tex = "" } })
