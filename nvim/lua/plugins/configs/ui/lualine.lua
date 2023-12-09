return {
	"nvim-lualine/lualine.nvim",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	event = "VeryLazy",
	opts = {
		options = { theme = 'base16' },
		extensions = { 'nvim-tree', 'fzf', 'quickfix', 'man' }
	}
}
