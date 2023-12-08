local utils = require "core.utils"
local lspconfig = require 'lspconfig'

local language_servers = {
	['nil_ls'] = {
		settings = {
			['nil'] = {
				formatting = {
					command = { "nixpkgs-fmt" },
				}
			},
		}
	},
	['tsserver'] = {},
	['rust_analyzer'] = {
		settings = {
			['rust-analyzer'] = {
				check = {
					invocationLocation = "root",
					overrideCommand = { "cargo", "check", "--message-format=json", "--all-targets" }
				},
				cargo = {
					features = {},
					buildScripts = {
						invocationLocation = "root",
						overrideCommand = { "cargo", "check", "--quiet", "--message-format=json", "--all-targets" }
					}
				}
			}
		},
		root_dir = lspconfig.util.root_pattern("Cargo.toml"),
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
	['clangd'] = {}
}

local default_on_attach = function(_, bufnr)
	local lsp_mappings = require('core.mappings').lspconfig
	utils.load_mapping(lsp_mappings, { noremap = true, buffer = bufnr })
end


local default_capabilities = vim.lsp.protocol.make_client_capabilities()

default_capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
}

for s, settings in pairs(language_servers) do
	-- Get on_attach
	settings['on_attach'] = settings['on_attach'] or default_on_attach

	-- Get capabilities
	settings['capabilities'] = settings['capabilities'] or default_capabilities

	lspconfig[s].setup(settings)
end
