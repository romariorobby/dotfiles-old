local core_modules = {
	"mario.globals",
	"mario.keymaps",
	"mario.autocmd",
	"mario.options",
	"mario.colorscheme",
}

for _, module in ipairs(core_modules) do
	local ok, err = pcall(require, module)
	if not ok then
		if module ==  "mario.keymaps" then
--			qs.source("lua/mario/keymaps.vim", true)
			vim.api.nvim_err_writeln("Error " .. module)
			require('mario.utils.misc').warn(module)
			goto continue
		end
		error("Error Loading " .. module .. "\n\n" .. err)
	end
	::continue::
end
