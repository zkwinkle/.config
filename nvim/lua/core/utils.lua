local M = {}

M.load_mapping = function(mapping, extra_opts)
	for mode, mode_values in pairs(mapping) do
		if mode == "opt" then goto continue end
		for keybind, mapping_info in pairs(mode_values) do
			if mode == "all" then
				mode = ""
			end

			local opts = {}
			if mapping_info.opts then
				opts = mapping_info.opts
			end
			if extra_opts then
				opts = vim.tbl_deep_extend("keep", opts, extra_opts)
			end

			vim.keymap.set(mode, keybind, mapping_info.map, opts)
		end
		::continue::
	end
end

return M
