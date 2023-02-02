local new_command = vim.api.nvim_create_user_command

new_command("Recolor", function()
	vim.api.nvim_command("source " .. package.searchpath("plugins.configs.base16", package.path))
	require("plugins.configs.others").lualine()
end, {})
