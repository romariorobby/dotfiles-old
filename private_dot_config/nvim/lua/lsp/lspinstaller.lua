local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	print("Hello")
	return
end
local handler = require('lsp.handlers')
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = handler.on_attach,
		capabillities = handler.capabillities,
	}
	-- for _, lang in pairs(server.name) do
	if server.name == "sumneko_lua" then
		local sumneko_opts = require("lsp.settings.lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end
	-- end
	server:setup(opts)
end)

-- (optional) Customize the options passed to the server
-- if server.name == "tsserver" then
--     opts.root_dir = function() ... end
-- end

-- This setup() function is exactly the same as lspconfig's setup function.
-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
