local status_ok, surround = pcall(require, "surround")
local surround_config = require "mario.config".plugins.surround.nvim_surround
if not status_ok then
	return
end

surround.setup {
  mappings_style = surround_config.style
}

