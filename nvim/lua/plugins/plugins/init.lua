return {

	{
		dir = "~/.config/nvim/lua/plugins/nvim-base16",
		name = "nvim-base16",
		config = function()
			require("plugins.configs.base16")
		end,
		lazy = false,
		priority = 1000,
	},

	{ "psliwka/vim-smoothie", },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		event = "VeryLazy",
		config = function()
			require("plugins.configs.others").lualine()
		end
	},


	{
		"norcalli/nvim-colorizer.lua",
		dependencies = { 'nvim-base16' },
		config = function()
			require("colorizer").setup()
		end
	},

	---- Misc
	{ "lambdalisue/suda.vim", },

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "VeryLazy",
	},

	-- git stuff
	{
		"lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		config = function()
			require("plugins.configs.others").gitsigns()
		end,
	},

	{
		"knsh14/vim-github-link",
		dependencies = 'gitsigns.nvim',
		config = function()
			require("plugins.configs.others").github_link()
		end,
	},
}
