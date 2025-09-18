-- Get LSP-like support for (h)ledger files
--
-- Provides:
-- - Syntax highlight
-- - Auto-format
-- - Auto-complete (of accounts with omni-complete ctrl-x ctrl-o)

return {
	"ledger/vim-ledger",
	ft = "ledger",
}
