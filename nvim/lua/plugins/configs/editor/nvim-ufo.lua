local utils = require "core.utils"
local mappings = require('core.mappings').nvim_tree

-- Using nvim LSP as the ufo provider. Therefore need to tell the server the
-- capability of foldingRange.
-- According to nvim-ufo README (September 2025):
--
--   Neovim hasn't added foldingRange to default capabilities, users must add it
--   manually
--
-- We set this in the `lua/plugins/configs/code/lspconfig.lua` file to keep LSP
-- config in one place.

return {
  "kevinhwang91/nvim-ufo",
  opts = {},
	keys = utils.mapping_to_lazy_keys(mappings),
  event = "VeryLazy",
}
