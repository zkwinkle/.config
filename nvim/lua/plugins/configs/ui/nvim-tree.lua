local utils = require "core.utils"
local mappings = require('core.mappings').nvimtree

-- floating window aspect ratio
local HEIGHT_RATIO = 0.9
local WIDTH_RATIO = 0.5

local git_toggle = function()
	local api = require("nvim-tree.api")
	local node = api.tree.get_node_under_cursor()
	local gs = node.git_status.file

	-- If the current node is a directory get children status
	if gs == nil then
		gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
				or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
	end

	-- If the file is untracked, unstaged or partially staged, we stage it
	if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
		vim.cmd("silent !git add " .. node.absolute_path)

		-- If the file is staged, we unstage
	elseif gs == "M " or gs == "A " then
		vim.cmd("silent !git restore --staged " .. node.absolute_path)
	end

	api.tree.reload()
end

local function my_on_attach(bufnr)
	local api = require "nvim-tree.api"

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.del('n', '<C-e>', { buffer = bufnr }) -- problems with floating

	-- remap
	vim.keymap.del('n', ']c', { buffer = bufnr })
	vim.keymap.del('n', '[c', { buffer = bufnr })
	vim.keymap.set('n', '[g', api.node.navigate.git.prev, opts('Prev Git'))
	vim.keymap.set('n', ']g', api.node.navigate.git.next, opts('Next Git'))

	-- custom mappings
	vim.keymap.set('n', 'gh', git_toggle, opts('Git Toggle'))
end

local setup = function()
	local tree_api = require("nvim-tree")
	local tree_view = require("nvim-tree.view")

	vim.api.nvim_create_augroup("NvimTreeResize", {
		clear = true,
	})

	vim.api.nvim_create_autocmd({ "VimResized" }, {
		group = "NvimTreeResize",
		callback = function()
			if tree_view.is_visible() then
				tree_view.close()
			end
		end
	})

	tree_api.setup({
		sort_by = "case_sensitive",
		on_attach = my_on_attach,
		view = {
			float = {
				enable = true,
				open_win_config = function()
					local screen_w = vim.opt.columns:get()
					local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
					local window_w = screen_w * WIDTH_RATIO
					local window_h = screen_h * HEIGHT_RATIO
					local window_w_int = math.floor(window_w)
					local window_h_int = math.floor(window_h)
					local center_x = (screen_w - window_w) / 2
					local center_y = ((vim.opt.lines:get() - window_h) / 2)
							- vim.opt.cmdheight:get()
					return {
						border = 'rounded',
						relative = 'editor',
						row = center_y,
						col = center_x,
						width = window_w_int,
						height = window_h_int,
					}
				end,
			},
			width = function()
				return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
			end,
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
	})
end
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = utils.mapping_to_lazy_keys(mappings),
	config = setup,
}
