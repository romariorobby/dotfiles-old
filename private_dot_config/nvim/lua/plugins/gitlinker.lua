local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
	return
end
local actions = require 'gitlinker.actions'

gitlinker.setup {
	opts = {
		add_current_line_on_normal_mode = true,
		action_callback = actions.copy_to_clipboard,
		-- action_callback = actions.open_in_browser,
		print_url = true,
	},
	mappings = "<leader>gy",
}
