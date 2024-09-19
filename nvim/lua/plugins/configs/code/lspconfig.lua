local utils = require "core.utils"

local setup = function()
	local lspconfig = require 'lspconfig'

	local snippet_support_capabilities = vim.lsp.protocol.make_client_capabilities()
	snippet_support_capabilities.textDocument.completion.completionItem.snippetSupport = true

	local language_servers = {
		['clangd'] = {},
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
		['nil_ls'] = {
			settings = {
				['nil'] = {
					formatting = {
						command = { "nixpkgs-fmt" },
					}
				},
			}
		},
		['marksman'] = {},
		['rust_analyzer'] = {
			settings = {
				['rust-analyzer'] = {
					check = {
						workspace = false,
					},
				}
			},
		},
		['ts_ls'] = {},
		['wgsl_analyzer'] = {},
		['sourcekit'] = {},
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
end

return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = setup,
}
