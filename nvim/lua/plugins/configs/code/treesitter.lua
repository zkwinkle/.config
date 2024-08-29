return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	cmd = {
		"TSInstall",
		"TSBufEnable",
		"TSBufDisable",
		"TSEnable",
		"TSDisable",
		"TSModuleInfo",
	},
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
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
		})
	end
}
