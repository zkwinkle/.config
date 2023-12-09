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
	opts = {
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
}
