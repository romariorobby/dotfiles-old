-- Disable Builtint Plugins
local disabled_builtin = {
   -- "2html_plugin",
   -- "getscript",
   -- "getscriptPlugin",
   -- "gzip",
   -- "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   -- "matchit",
   -- "tar",
   -- "tarPlugin",
   -- "rrhelper",
   -- "spellfile_plugin",
   -- "vimball",
   -- "vimballPlugin",
   -- "zip",
   -- "zipPlugin",
}

for _, plugin in pairs(disabled_builtin) do
   vim.g["loaded_" .. plugin] = 1
end

-- Builtin plugins config
-- require("plugins.netrw")


