return require("packer").startup(function()
	use "wbthomason/packer.nvim"
	use "EdenEast/nightfox.nvim"
	use "hoob3rt/lualine.nvim"
	use "kyazdani42/nvim-tree.lua"

	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate"
	}

end)
