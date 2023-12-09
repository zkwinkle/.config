local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = {
		lazy = true -- lazy-load all plugins by default
	},
	browser = "firefox",
	checker = {
		enabled = true, -- automatically check for plugin updates
	},
	-- lockfile generated after running update.
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
}

local modules = {
	{ import = "plugins.configs" },
	{ import = "plugins.configs.code" },
	{ import = "plugins.configs.editor" },
	{ import = "plugins.configs.git" },
	{ import = "plugins.configs.ui" },
}

require("lazy").setup(modules, opts)
