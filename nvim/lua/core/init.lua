require "core.options"
require "core.commands"

local utils = require "core.utils"
local mappings = require "core.mappings"
for _, mapping in pairs(mappings) do
	if mapping.opt then goto continue end
	utils.load_mapping(mapping, { noremap = true })
	::continue::
end
