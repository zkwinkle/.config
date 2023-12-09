local config = {
	max_phase_one_targets = nil,
	highlight_unlabeled_phase_one_targets = false,
	max_highlighted_traversal_targets = 10,
	case_sensitive = false,
	equivalence_classes = { ' \t\r\n', },
	substitute_chars = {},
	safe_labels = 'sfnut/?',
	labels = 'sfnjklhodweimbuyvrgtaqpcxz/?',
	special_keys = {
		next_target = '<enter>',
		prev_target = '<tab>',
		next_group = '<space>',
		prev_group = '<tab>',
		multi_accept = '<enter>',
		multi_revert = '<backspace>',
	}
}

local setup = function()
	local leap = require("leap")

	leap.add_default_mappings()
	leap.opts = config
end


return {
	"ggandor/leap.nvim",
	event = "VeryLazy",
	config = setup
}
