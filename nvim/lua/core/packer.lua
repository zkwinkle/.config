local M = {}

M.options = {
	auto_clean = true,
	compile_on_sync = true,
	display = {
		working_sym = "ﲊ",
		error_sym = "✗ ",
		done_sym = " ",
		removed_sym = " ",
		moved_sym = "",
		open_fn = function()
			return require("packer.util").float { border = "single" }
		end,
	},
}

M.run = function(plugins)
	local present, packer = pcall(require, "packer")

	if not present then
		return
	end

	packer.init(M.options)

	packer.startup(function(use)
		for plugin_name, options in pairs(plugins) do
			options[1] = plugin_name
			use(options)
		end
	end)
end

return M
