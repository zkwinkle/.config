require "core.options"
require "core.commands"

local utils = require "core.utils"
local mappings = require "core.mappings"

utils.load_mapping(mappings.base, { noremap = true })
