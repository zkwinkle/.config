require "core.options"

-- comment
local utils = require "core.utils"
local mappings = require "core.mappings"
--mappings.lspconfig = nil
for _, mapping in pairs(mappings) do
	utils.load_mapping(mapping, { noremap = true })
end
