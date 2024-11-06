local M = {}

M.load_mapping = function(mapping, extra_opts)
	for mode, mode_keys in pairs(mapping) do
		for keybind, mapping_info in pairs(mode_keys) do
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
	end
end


M.mapping_to_lazy_keys = function(mapping, extra_opts)
	local lazy_keys = {}

	for mode, mode_keys in pairs(mapping) do
		for keybind, mapping_info in pairs(mode_keys) do
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

			local lazy_key = { keybind, mapping_info.map, mode = mode, ft = mapping_info.ft }
			lazy_key = vim.tbl_deep_extend("keep", lazy_key, opts)

			table.insert(lazy_keys, lazy_key)

			vim.keymap.set(mode, keybind, mapping_info.map, opts)
		end
	end

	return lazy_keys
end

return M
