-- Install Packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- Load plugins
require "plugins"

-- Material Theme
require('material').set()
vim.g.material_style = "lighter"

-- Status Line
require('lualine').setup{
	options = {theme = 'papercolor_light'}
}

-- compe
require("completion")
