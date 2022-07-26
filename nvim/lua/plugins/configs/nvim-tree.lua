local present, nvimtree = pcall(require, "nvim-tree")

if not present then
	return
end

local options = {
	sort_by = "case_sensitive",
	view = {
		width = 24,
		side = "left",
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
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
	filters = { -- Files to ignore
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
}

nvimtree.setup(options)
