local new_command = vim.api.nvim_create_user_command

new_command("Recolor", function()
	vim.cmd("source $XDG_CONFIG_HOME/nvim/lua/plugins/nvim-base16/colors.lua")
	vim.cmd("Lazy reload lualine.nvim")
end, {})
