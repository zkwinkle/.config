local utils = require "core.utils"
local mappings = require('core.mappings').github_link

return {
	"knsh14/vim-github-link",
	dependencies = 'gitsigns.nvim',
	keys = utils.mapping_to_lazy_keys(mappings, { noremap = true }),
}
