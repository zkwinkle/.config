return {
	dir = "~/.config/nvim/lua/plugins/nvim-base16",
	name = "nvim-base16",
	config = function()
		require("plugins.nvim-base16.colors")
	end,
	lazy = false,
	priority = 1000,
}
