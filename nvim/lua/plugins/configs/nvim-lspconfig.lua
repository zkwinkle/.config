local utils = require "core.utils"

local on_attach = function(client, bufnr)
	local lsp_mappings = require('core.mappings').lspconfig
	utils.load_mapping(lsp_mappings, { noremap = true, buffer = bufnr })
end


local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
}

local language_servers = {
	['tsserver'] = {},
	['rust_analyzer'] = {},
	['sumneko_lua'] = {
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
	},
	--'pylsp',
}

local lspconfig = require 'lspconfig'

for s, settings in pairs(language_servers) do
	lspconfig[s].setup {
		on_attach = on_attach,
		capabilities = capabilities,
		settings = settings,
	}
end
