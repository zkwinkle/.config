vim.cmd "packadd packer.nvim"

local plugins = {

	["wbthomason/packer.nvim"] = {},

	---- nvim tree related plugins
	["kyazdani42/nvim-web-devicons"] = {},

	["kyazdani42/nvim-tree.lua"] = {
		-- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require "plugins.configs.nvim-tree"
		end,
	},

	---- Language/format supports
	--Plug 'rust-lang/rust.vim' " Rust support
	
	-- Pretty stuff :3
	--Plug 'fladson/vim-kitty', { 'branch': 'main'} " Syntax highlighting based on kitty terminal's config
	['psliwka/vim-smoothie'] = {},
	
	['AlphaTechnolog/pywal.nvim'] = { as = 'pywal' , 
	config = function()
		require('pywal').setup()
	end},
	['nvim-lualine/lualine.nvim'] = {
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup {
				options = {theme = 'pywal-nvim'},
				extensions = {'nvim-tree'}
			}
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


	--["lukas-reineke/indent-blankline.nvim"] = {
	--  opt = true,
	--  setup = function()
	--    require("core.lazy_load").on_file_open "indent-blankline.nvim"
	--  end,
	--  config = function()
	--    require("plugins.configs.others").blankline()
	--  end,
	--},

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

	--["williamboman/nvim-lsp-installer"] = {
	--  opt = true,
	--  cmd = require("core.lazy_load").lsp_cmds,
	--  setup = function()
	--    require("core.lazy_load").on_file_open "nvim-lsp-installer"
	--  end,
	--},

	--["neovim/nvim-lspconfig"] = {
	--  after = "nvim-lsp-installer",
	--  module = "lspconfig",
	--  config = function()
	--    require "plugins.configs.lsp_installer"
	--    require "plugins.configs.lspconfig"
	--  end,
	--},

	--["numToStr/Comment.nvim"] = {
	--  module = "Comment",
	--  keys = { "gc", "gb" },
	--  config = function()
	--    require("plugins.configs.others").comment()
	--  end,
	--},

}

require("core.packer").run(plugins)
