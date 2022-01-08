vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == "Darwin" and "open" or "xdg-open"
vim.g.userConfig = vim.fn.stdpath("config") .. "/mario/config.lua"
vim.g.pluginInit = vim.fn.stdpath("config") .. "/lua/plugins/init.lua"
vim.g.fontDir = vim.g.os == "Darwin" and "~/Library/Fonts/*/*" or "/usr/share/fonts/*/*"
vim.g.syncthingDir = vim.env.SYNC_DIR
vim.g.notesDir = vim.env.NOTES_DIR
vim.g.ledgerDir = vim.env.LEDGER_DIR

local modules = {
	"impatient",
	"mario",
	"plugins",
}

for _, module in ipairs(modules) do
	local status_ok, err = pcall(require, module)
	if not status_ok then
		error("Error Loading " .. module .. "\n\n" .. err)
	end
end
