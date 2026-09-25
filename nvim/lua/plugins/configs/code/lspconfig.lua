local utils = require "core.utils"

local setup = function()
  local snippet_support_capabilities = vim.lsp.protocol.make_client_capabilities()
  snippet_support_capabilities.textDocument.completion.completionItem.snippetSupport = true

  local language_servers = {
    ['astro'] = {},
    ['clangd'] = {},
    ['roslyn_ls'] = {},
    ['cssls'] = {
      capabilities = snippet_support_capabilities
    },
    ['html'] = {
      capabilities = snippet_support_capabilities
    },
    ['lua_ls'] = {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            },
            maxPreload = 500,
            preloadFileSize = 10000,
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      }
    },
    ['marksman'] = {},
    ['nil_ls'] = {
      settings = {
        ['nil'] = {
          formatting = {
            command = { "nixpkgs-fmt" },
          }
        },
      }
    },
    ['basedpyright'] = {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "basic",
          },
        },
      },
    },
    ['ruff'] = {},
    -- Replaced by rustaceanvim
    --
    -- ['rust_analyzer'] = {
    --   settings = {
    --     ['rust-analyzer'] = {
    --       check = {
    --         workspace = false,
    --       },
    --     }
    --   },
    -- },
    ['ts_ls'] = {},
    ['wgsl_analyzer'] = {},
    ['sourcekit'] = {},
  }

  -- Set LSP keymaps on attachment
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_mappings', { clear = true }),
    callback = function(args)
      utils.load_mapping(require('core.mappings').lspconfig,
        { noremap = true, buffer = args.buf })
    end,
  })


  local default_capabilities = vim.lsp.protocol.make_client_capabilities()

  default_capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
  }

  for s, settings in pairs(language_servers) do
    -- Get capabilities
    settings['capabilities'] = settings['capabilities'] or default_capabilities

    vim.lsp.config(s, settings)
    vim.lsp.enable(s)
  end

  --- Vim global settings related to LSP and diagnostics
  vim.diagnostic.config({
    jump = { float = true },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = ' ',
        [vim.diagnostic.severity.WARN] = ' ',
        [vim.diagnostic.severity.INFO] = ' ',
        [vim.diagnostic.severity.HINT] = '󰌶'
      }
    }
  }) -- open diagnostic upon jumping

end

return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  config = setup,
}
