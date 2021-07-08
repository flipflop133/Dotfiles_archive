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
			require("treesitter-nvim").config()
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
			require'compe'.setup {
				enabled = true,
				autocomplete = true,
				debug = false,
				min_length = 1,
				preselect = 'enable',
				throttle_time = 80,
				source_timeout = 200,
				incomplete_delay = 400,
				max_abbr_width = 100,
				max_kind_width = 100,
				max_menu_width = 100,
				documentation = true,
				source = {
					buffer = true,
					calc = true,
					nvim_lsp = true,
					nvim_lua = true,
					path = true,
					snippets_nvim = true,
					spell = true,
					tags = true,
					treesitter = true,
					vsnip = true,
					zsh = true
				}
			}
		end
	}

	-- Icons
	use "kyazdani42/nvim-web-devicons"
end)
