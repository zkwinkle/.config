local utils = require "core.utils"
local mappings = require('core.mappings').gitsigns

local function recolor_git_signs_staged_highlights()
  local highlight_groups = vim.fn.getcompletion('GitSignsStaged', 'highlight')

  for _, group in ipairs(highlight_groups) do
    -- Create the corresponding group name without "Staged"
    local base_group = group:gsub('Staged', '')
    local hl = vim.api.nvim_get_hl(0, { name = base_group, link = false })
    local is_bg_light = vim.o.background == 'light'

    vim.api.nvim_set_hl(0, group, {
      bg = hl.bg,
      fg = utils.cmix(hl.fg, 0.5 * (is_bg_light and 1 or -1)),
      ctermbg = hl.ctermbg,
      ctermfg = hl.ctermfg,
    })
  end
end

return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  config = function()
    -- Staged highlights don't get refreshed by changing the base16 theme, so
    -- we need to refresh them after a background change.
    vim.api.nvim_create_autocmd("OptionSet", {
      pattern = "background",
      callback = recolor_git_signs_staged_highlights,
    })
  end,
  opts = {}, -- necessary for lazy to call the setup()
  keys = utils.mapping_to_lazy_keys(mappings, { noremap = true }),
}
