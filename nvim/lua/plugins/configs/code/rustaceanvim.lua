local utils = require "core.utils"

local function load_project_ra_settings()
  local root = vim.fn.getcwd()
  local path = root .. '/.rustaceanvim/rust-analyzer.json'
  if vim.fn.filereadable(path) == 0 then
    return nil
  end
  local raw = table.concat(vim.fn.readfile(path), '\n')
  local ok, decoded = pcall(vim.fn.json_decode, raw)
  if not ok or type(decoded) ~= 'table' then
    return nil
  end
  return decoded
end

local project_ra = load_project_ra_settings()

local ra_settings = {
  -- global/default RA settings
  check = {
    workspace = false,
  },
}

if project_ra then
  ra_settings = vim.tbl_deep_extend("force", ra_settings, project_ra)
end

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
      ['rust-analyzer'] = ra_settings
    },
  },
}

return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false,   -- This plugin is already lazy
}
