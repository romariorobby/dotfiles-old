local cmd = vim.cmd
local fn = vim.fn
local execute = vim.api.nvim_command
cmd("packadd packer.nvim")

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

	-- if fn.empty(fn.glob(install_path)) > 0 then
  -- 	PACKER_BOOTSTRAP = fn.system {
	-- 		"git",
	-- 		"clone",
	-- 		"--depth",
	-- 		"1",
	-- 		"https://github.com/wbthomason/packer.nvim",
	-- 		install_path,
	-- 	}
	-- end
	-- remove the dir before cloning
	print("Cloning packer..")
	fn.delete(packer_path, "rf")
	PACKER_BOOSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		packer_path,
	})

	cmd("packadd packer.nvim")
	status_ok, packer = pcall(require, "packer")

	if status_ok then
		print("Packer cloned successfully.\nClose and reopen Neovim..")
	else
		error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
	end
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
		prompt_border = "single",
	},
	git = {
		clone_timeout = 600, -- Timeout, in seconds, for git clones
	},
	auto_clean = true,
	compile_on_sync = true,
	--    auto_reload_compiled = true
})

function SetupPackerMap()
	vim.cmd[[
	augroup setup_packermap
		autocmd!
		nnoremap <buffer> <localleader>s <cmd>PackerSync<cr>
		nnoremap <buffer> <localleader>u <cmd>PackerUpdate<cr>
		set filetype=lua
	augroup end
	]]
end
vim.cmd[[exe "autocmd BufEnter" g:pluginInit " lua SetupPackerMap()"]]

return packer
