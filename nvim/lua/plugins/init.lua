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
	
	-- Went back to wal.vim because comments were white and it made lualine ugly
	--["oncomouse/lushwal"] = {
	--	requires = { { "rktjmp/lush.nvim", opt = true }, { "rktjmp/shipwright.nvim", opt = true } },
	--	config = function() 
	--		require "plugins.configs.lushwal"
	--	end
	--},
	
	--Changed to pywal.nvim because it's more consistent with nvim-tree and other plugins
	--['sprockmonty/wal.vim'] = { -- branch that lets termgui colors be on
	--	config = function()
	--		--vim.cmd('colorscheme wal')
	--		--vim.opt.termguicolors = true
	--	end
	--},
	['AlphaTechnolog/pywal.nvim'] = { as = 'pywal' , 
	config = function()
		require('pywal').setup()
	end},
	['nvim-lualine/lualine.nvim'] = {
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup {
				options = {theme = 'pywal-nvim'}
			}
		end
	},
	
	-- fade inactive panes
	['TaDaa/vimade'] = {
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

	--["nvim-treesitter/nvim-treesitter"] = {
	--  module = "nvim-treesitter",
	--  setup = function()
	--    require("core.lazy_load").on_file_open "nvim-treesitter"
	--  end,
	--  cmd = require("core.lazy_load").treesitter_cmds,
	--  run = ":TSUpdate",
	--  config = function()
	--    require "plugins.configs.treesitter"
	--  end,
	--},

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
