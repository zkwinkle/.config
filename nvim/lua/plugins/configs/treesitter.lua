treesitter = require "nvim-treesitter.configs"

local options = {
	ensure_installed = {
		"lua",
		"rust",
		"python",
		"c",
	},
	auto_install = true,
	highlight = {
		enable = true,
		use_languagetree = true,
	},
	indent = {
		enable = true
	}
}

treesitter.setup(options)
