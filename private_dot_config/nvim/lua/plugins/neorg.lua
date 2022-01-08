local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
	return
end

neorg.setup {
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					my_workspace = "~/neorg"
				}
			}
		},
		["core.intergrations.telescope"] = {},
	},
}
