vim.cmd "packadd packer.nvim"

local plugins = {

	["wbthomason/packer.nvim"] = {},
	["lewis6991/impatient.nvim"] = {},

	---- nvim tree related plugins
	["kyazdani42/nvim-web-devicons"] = {},

	["kyazdani42/nvim-tree.lua"] = {
		-- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require "plugins.configs.nvim-tree"
		end,
	},

	-- Pretty stuff :3
	--Plug 'fladson/vim-kitty', { 'branch': 'main'} " Syntax highlighting based on kitty terminal's config
	['psliwka/vim-smoothie'] = {},

	['AlphaTechnolog/pywal.nvim'] = { as = 'pywal',
		config = function()
			require('pywal').setup()
		end },

	['nvim-lualine/lualine.nvim'] = {
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		opt = true,
		setup = function()
			require("core.lazy_load").on_file_open "lualine.nvim"
		end,
		config = function()
			require("plugins.configs.others").lualine()
		end
	},

	-- fade inactive panes
	['TaDaa/vimade'] = {
		opt = true, event = 'BufAdd',
		config = function()
			vim.g.vimade = { fadelevel = 0.65 }
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
	--["lewis6991/gitsigns.nvim"] = {
	--  ft = "gitcommit",
	--  setup = function()
	--    require("core.lazy_load").gitsigns()
	--  end,
	--  config = function()
	--    require("plugins.configs.others").gitsigns()
	--  end,
	--},

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

}

require("core.packer").run(plugins)
