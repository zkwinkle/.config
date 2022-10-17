require "core.options"

local utils = require "core.utils"
local mappings = require "core.mappings"
for k, mapping in pairs(mappings) do
	if k == 'lspconfig' then goto continue end
	utils.load_mapping(mapping, { noremap = true })
	::continue::
end
