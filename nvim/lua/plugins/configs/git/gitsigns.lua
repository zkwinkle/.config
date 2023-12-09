local utils = require "core.utils"
local mappings = require('core.mappings').gitsigns

return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	opts = {}, -- necessary for lazy to call the setup()
	keys = utils.mapping_to_lazy_keys(mappings, { noremap = true }),
}
