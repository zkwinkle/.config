vim.cmd "packadd packer.nvim"

local plugins = {

	["wbthomason/packer.nvim"] = {},
	["lewis6991/impatient.nvim"] = {},

	---- nvim tree related plugins
	["nvim-tree/nvim-web-devicons"] = {
		requires = { 'nvim-base16' },
		after = { 'nvim-base16' },
		config = function()
			require "plugins.configs.nvim-web-devicons"
		end,
	},

	["nvim-tree/nvim-tree.lua"] = {
		--cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		requires = "nvim-tree/nvim-web-devicons",
		after = { "nvim-web-devicons" },
		config = function()
			require "plugins.configs.nvim-tree"
		end,
	},

	-- Pretty stuff :3
	-- Modified version of RRethy/nvim-base16
	['~/.config/nvim/lua/plugins/nvim-base16'] = {
		config = function()
			require("plugins.configs.base16")
		end
	},

	['psliwka/vim-smoothie'] = {},

	['nvim-lualine/lualine.nvim'] = {
		requires = { 'nvim-tree/nvim-web-devicons', opt = true },
		opt = true,
		setup = function()
			require("core.lazy_load").on_file_open "lualine.nvim"
		end,
		config = function()
			require("plugins.configs.others").lualine()
		end
	},


	['norcalli/nvim-colorizer.lua'] = {
		requires = { 'nvim-base16' },
		config = function()
			require("colorizer").setup()
		end
	},

	---- Misc
	['lambdalisue/suda.vim'] = {},


	["lukas-reineke/indent-blankline.nvim"] = {
		opt = true,
		setup = function()
			require("core.lazy_load").on_file_open "indent-blankline.nvim"
		end,
		config = function()
			require("plugins.configs.others").blankline()
		end,
	},

	["nvim-treesitter/nvim-treesitter"] = {
		module = "nvim-treesitter",
		setup = function()
			require("core.lazy_load").on_file_open "nvim-treesitter"
		end,
		cmd = require("core.lazy_load").treesitter_cmds,
		run = ":TSUpdate",
		config = function()
			require "plugins.configs.treesitter"
		end,
	},

	-- git stuff
	["lewis6991/gitsigns.nvim"] = {
		ft = "gitcommit",
		setup = function()
			require("core.lazy_load").gitsigns()
		end,
		config = function()
			require("plugins.configs.others").gitsigns()
		end,
	},

	-- lsp stuff

	["neovim/nvim-lspconfig"] = {
		config = function()
			require "plugins.configs.lspconfig"
		end,
	},

	--["numToStr/Comment.nvim"] = {
	--  module = "Comment",
	--  keys = { "gc", "gb" },
	--  config = function()
	--    require("plugins.configs.others").comment()
	--  end,
	--},

	-- fzf
	['ibhagwan/fzf-lua'] = {
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require "plugins.configs.fzf-lua"
		end,
	}

}

require("core.packer").run(plugins)
