return {
	"arborist-ts/arborist.nvim",
	event = "VeryLazy",
	build = ":ArboristUpdate",
	config = function()
		require("arborist").setup({
			ensure_installed = {
				"lua",
				"rust",
				"python",
				"c",
			},
		})
	end
}
