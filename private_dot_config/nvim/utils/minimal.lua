
vim.cmd("packadd packer.nvim")
return require('packer').startup(function(use)
	use {'wbthomason/packer.nvim'}

  use {
		'numToStr/Comment.nvim',
		config = function()
      require('Comment').setup()
--			require('plugins.comment')
		end
	}
end)
