local utils = require "core.utils"

local M = {}

M.lualine = function()
	require('lualine').setup {
		options = { theme = 'base16' },
		extensions = { 'nvim-tree', 'fzf', 'quickfix', 'man' }
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

M.github_link = function()
	local gh_link_mappings = require('core.mappings').github_link
	utils.load_mapping(gh_link_mappings, { noremap = true })
end

return M
