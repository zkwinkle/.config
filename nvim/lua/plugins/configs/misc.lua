local utils = require "core.utils"
local mappings = require('core.mappings')

return {
	{
		"lambdalisue/suda.vim",
		cmd = { "SudaWrite", "SudaRead" }
	},
	{
		"tamton-aquib/duck.nvim",
		keys = utils.mapping_to_lazy_keys(mappings.duck),
	},
}
