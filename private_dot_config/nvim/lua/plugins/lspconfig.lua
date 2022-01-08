local status_ok, _ = require('lspconfig')
if not status_ok then
	return
end

require('lsp.lspinstaller')
require('lsp.handlers').setup()
