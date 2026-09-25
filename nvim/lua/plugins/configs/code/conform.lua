local utils = require "core.utils"
local mappings = require('core.mappings').conform

return {
  "stevearc/conform.nvim",
  keys = utils.mapping_to_lazy_keys(mappings, { noremap = true }),
  opts = {
    -- Add custom formatters per file type here
    formatters_by_ft = {
      cs = { "csharpier" },
    },
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 5000,
    },
  },
}
