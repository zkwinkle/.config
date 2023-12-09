local utils = require "core.utils"
local mappings = require('core.mappings').nvimtree

return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = utils.mapping_to_lazy_keys(mappings),
	opts = {
		sort_by = "case_sensitive",
		view = {
			width = 24,
			side = "left",
			adaptive_size = true,
		},
		renderer = {
			icons = {
				show = {
					git          = true,
					folder       = true,
					file         = true,
					folder_arrow = false
				},
			},
			indent_markers = {
				enable = true
			},
			highlight_git = true,
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		},
		filters = {
			-- Files to ignore
			dotfiles = true,
			custom = {
				'.git',
				'node_modules',
				'.cache'
			}
		},
		actions = {
			open_file = {
				quit_on_open = true,
			}
		}
	},
}
