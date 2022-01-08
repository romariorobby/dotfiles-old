local status_ok, indent = pcall(require, "indent_blankline")
if not status_ok then
	return
end

indent.setup({
	-- char = "|",
	show_end_of_line = true,
	space_char_blankline = " ",
	buftype_exclude = {
		"terminal",
		"help",
		"dashboard",
	},
	filetype_exclude = {
		"help",
		"dashboard",
		"lspinfo",
		"null-ls-info",
		"NvimTree",
		"packer",
		"alpha",
		"tsplayground",
	},
	show_current_context = true,
	show_current_context_start = true,
})
