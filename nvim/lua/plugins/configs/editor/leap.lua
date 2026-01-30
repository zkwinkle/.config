local utils = require "core.utils"
local mappings = require('core.mappings').leap

return {
  url = "https://codeberg.org/andyg/leap.nvim",
  event = "VeryLazy",
  keys = utils.mapping_to_lazy_keys(mappings),
  config = {
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
}
