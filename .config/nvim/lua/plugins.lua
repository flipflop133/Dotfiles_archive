return require('packer').startup(function()
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

	-- Material theme
	use {
		'marko-cerovac/material.nvim',
		config = function() 
			vim.g.material_style = "lighter"
			require('material').set()
		end
	}

	-- Status line
	use {
		'hoob3rt/lualine.nvim',
		config = function()
			require'lualine'.setup{options={theme = 'material-nvim'}}
		end
	}

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require("treesitter-nvim")
		end
	}

	-- LSP
	use {
		"neovim/nvim-lspconfig",
		config = function()
			require "lsp"
		end
	}

	use {
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init()
		end
	}

	use 'kabouzeid/nvim-lspinstall'


	-- Formatting
	use {
		"sbdchd/neoformat",
		config = function()
			require "neoformat"
		end,
	}

	-- Completion
	use {
		'hrsh7th/nvim-compe',
		requires = {{'hrsh7th/vim-vsnip'}},
		config = function()
			require('completion')
		end
	}

	-- Icons
	use "kyazdani42/nvim-web-devicons"

	-- File manager
	use {
		"mcchrish/nnn.vim",
		cmd = {"Np", "NnnPicker"}
	}
end)
