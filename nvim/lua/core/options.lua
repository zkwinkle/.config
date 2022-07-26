local opt = vim.opt
local g = vim.g

g.mapleader = " "

opt.laststatus = 3 -- global statusline
opt.fillchars = { eob = " " }
opt.errorbells = false
opt.visualbell = false
opt.hidden = true
opt.signcolumn = "yes:1"

-- Numbers
opt.number = true
opt.relativenumber = true

-- Center cursor in the middle of the screen
opt.scrolloff = 999
--opt.cul = true -- cursor line

-- Indenting
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- For / search
opt.ignorecase = true
opt.smartcase = true

opt.mouse = "a" -- Mouse support

opt.splitbelow = true
opt.splitright = true

-- disable some builtin vim plugins
local default_plugins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for _, plugin in pairs(default_plugins) do
	g["loaded_" .. plugin] = 1
end
