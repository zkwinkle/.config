local utils = require "core.utils"

vim.g.rustaceanvim = {
  -- Plugin configuration
  -- tools = {
  -- },

  -- DAP configuration
  -- dap = {
  -- },

  -- LSP configuration
  server = {
    on_attach = function(_, bufnr)
      local lsp_mappings = require('core.mappings').lspconfig
      local rust_only_mappings = require('core.mappings').rustaceanvim

      local mappings = vim.tbl_deep_extend("force", lsp_mappings, rust_only_mappings)
      utils.load_mapping(mappings, { noremap = true, buffer = bufnr })
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        check = {
          workspace = false,
        },
      }
    },
  },
}

return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false,   -- This plugin is already lazy
}
