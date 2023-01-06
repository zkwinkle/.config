local utils = require "core.utils"

local M = {}

M.lualine = function()
	require('lualine').setup {
		options = { theme = 'pywal-nvim' },
		extensions = { 'nvim-tree', 'quickfix', 'fzf' }
	}
end

M.blankline = function()
	require "indent_blankline".setup {
		filetype_exclude = {
			"help",
			"terminal",
			"alpha",
			"packer",
			"lspinfo",
			--"TelescopePrompt",
			--"TelescopeResults",
			"lsp-installer",
			"",
		},
		buftype_exclude = { "terminal" },
		show_trailing_blankline_indent = false,
		show_first_indent_level = false,
		show_current_context = true,
		show_current_context_start = false,
	}
end

M.gitsigns = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  gitsigns.setup()

	local git_mappings = require('core.mappings').gitsigns
	utils.load_mapping(git_mappings, { noremap = true })
end

return M
