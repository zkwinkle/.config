require "core.options"

-- comment
local utils = require "core.utils"
for _, mapping in pairs(require("core.mappings")) do
	utils.load_mapping(mapping)
end
