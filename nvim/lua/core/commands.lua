local new_command = vim.api.nvim_create_user_command

new_command("Recolor", function()
	vim.api.nvim_command("source $XDG_CONFIG_HOME/nvim/lua/plugins/configs/base16.lua")
	require("plugins.configs.others").lualine()
end, {})
