local M = {}

M.load_mapping = function (mapping)
	for mode, mode_values in pairs(mapping) do
		for keybind, mapping_info in pairs(mode_values) do
			if mode == "all" then
				mode = ""
			end

			vim.api.nvim_set_keymap(mode, keybind, mapping_info.map, mapping_info.opts)
		end
	end
end

return M

