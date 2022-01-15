local cmd = vim.cmd
local fn = vim.fn
local execute = vim.api.nvim_command
-- cmd("packadd packer.nvim")

local present, packer = pcall(require, "packer")
if not present then
-- if vim.fn.input "Download Packer? (y for yes) " ~= "y" then
--    return
-- end
	local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

	print("Cloning packer..")
	-- remove the dir before cloning
	fn.delete(packer_path, "rf")
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		packer_path,
	})
	print(PACKER_BOOTSTRAP)
	cmd("packadd packer.nvim")
	ready, packer = pcall(require, "packer")
--
	if ready then
		vim.notify("Close and reopen Neovim..", "info")
		if vim.fn.input "Quit Now ? (y for yes) " == "y" then
			vim.cmd[[silent :qa!]]
		end
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
