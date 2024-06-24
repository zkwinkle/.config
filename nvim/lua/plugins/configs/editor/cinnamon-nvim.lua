return {
	"declancm/cinnamon.nvim",
	config = function()
		require('cinnamon').setup {
			default_keymaps = true, -- Create default keymaps.
			extra_keymaps = true,  -- Create extra keymaps.
			extended_keymaps = true, -- Create extended keymaps.
			override_keymaps = false, -- The plugin keymaps will override any existing keymaps.
		}
	end,
	event = "VeryLazy"
}
