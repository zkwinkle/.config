-- Base16 setup logic adapted from lualine base16 theme
local function warning(notice)
	notice = 'theme(base16): ' .. notice
	print(notice)
end

local function setup_base16()
	local loaded, base16 = pcall(require, 'base16-colorscheme')

	if not loaded then
		warning(
			'nvim-base16 is not currently present in your runtimepath, make sure it is properly installed,'
			.. ' fallback to default colors.'
		)

		return nil
	end

	if not base16.colors and not vim.env.BASE16_THEME then
		print("colors:", base16.colors)
		warning(
			'nvim-base16 is not loaded yet, you should update your configuration to load it before nvim-web-devicons'
			.. ' so that the colors from your colorscheme can be used, fallback to default colors.'
		)
		return nil
	elseif not base16.colors and not base16.colorschemes[vim.env.BASE16_THEME] then
		warning(
			'The colorscheme "%s" defined by the environment variable "BASE16_THEME" is not handled by'
			.. ' nvim-base16, fallback to default colors.'
		)
		return nil
	end

	local base16_colors = base16.colors or base16.colorschemes[vim.env.BASE16_THEME or 'tomorrow-night']

	local colors = {
		dark_gray = base16_colors.base03,
		gray = base16_colors.base04,
		fg = base16_colors.base05,
		light = base16_colors.base06,
		white = base16_colors.base07,

		red = base16_colors.base08,
		orange = base16_colors.base09,
		yellow = base16_colors.base0A,
		green = base16_colors.base0B,
		cyan = base16_colors.base0C,
		blue = base16_colors.base0D,
		magenta = base16_colors.base0E,
		special = base16_colors.base0F,
	}

	local override = {
		[".bash_profile"] = {
			icon = "",
			color = colors.red,
			name = "BashProfile",
		},
		[".bashrc"] = {
			icon = "",
			color = colors.red,
			name = "Bashrc",
		},
		[".gitattributes"] = {
			icon = "",
			color = colors.orange,
			name = "GitAttributes",
		},
		[".gitconfig"] = {
			icon = "",
			color = colors.orange,
			name = "GitConfig",
		},
		[".gitignore"] = {
			icon = "",
			color = colors.orange,
			name = "GitIgnore",
		},
		[".gitmodules"] = {
			icon = "",
			color = colors.orange,
			name = "GitModules",
		},
		[".npmignore"] = {
			icon = "",
			color = colors.red,
			name = "NPMIgnore",
		},
		[".npmrc"] = {
			icon = "",
			color = colors.red,
			name = "NPMrc",
		},
		[".settings.json"] = {
			icon = "",
			color = colors.magenta,
			name = "SettingsJson",
		},
		[".vimrc"] = {
			icon = "",
			color = colors.green,
			name = "Vimrc",
		},
		[".zprofile"] = {
			icon = "",
			color = colors.red,
			name = "Zshprofile",
		},
		[".zshenv"] = {
			icon = "",
			color = colors.red,
			name = "Zshenv",
		},
		[".zshrc"] = {
			icon = "",
			color = colors.red,
			name = "Zshrc",
		},
		["CMakeLists.txt"] = {
			icon = "",
			color = colors.green,
			name = "CMakeLists",
		},
		["COMMIT_EDITMSG"] = {
			icon = "",
			color = colors.orange,
			name = "GitCommit",
		},
		["Containerfile"] = {
			icon = "",
			color = colors.blue,
			name = "Dockerfile",
		},
		["Dockerfile"] = {
			icon = "",
			color = colors.blue,
			name = "Dockerfile",
		},
		["LICENSE"] = {
			icon = "",
			color = colors.yellow,
			name = "License",
		},
		["_gvimrc"] = {
			icon = "",
			color = colors.green,
			name = "Gvimrc",
		},
		["_vimrc"] = {
			icon = "",
			color = colors.green,
			name = "Vimrc",
		},
		["awk"] = {
			icon = "",
			color = colors.gray,
			name = "Awk",
		},
		["bash"] = {
			icon = "",
			color = colors.gray,
			name = "Bash",
		},
		["bmp"] = {
			icon = "",
			color = colors.magenta,
			name = "Bmp",
		},
		["c"] = {
			icon = "",
			color = colors.blue,
			name = "C",
		},
		["c++"] = {
			icon = "",
			color = colors.cyan,
			name = "CPlusPlus",
		},
		["cc"] = {
			icon = "",
			color = colors.cyan,
			name = "CPlusPlus",
		},
		["cfg"] = {
			icon = "",
			color = colors.light,
			name = "Configuration",
		},
		["cmake"] = {
			icon = "",
			color = colors.green,
			name = "CMake",
		},
		["conf"] = {
			icon = "",
			color = colors.light,
			name = "Conf",
		},
		["cp"] = {
			icon = "",
			color = colors.cyan,
			name = "Cp",
		},
		["cpp"] = {
			icon = "",
			color = colors.cyan,
			name = "Cpp",
		},
		["cs"] = {
			icon = "",
			color = colors.magenta,
			name = "Cs",
		},
		["csh"] = {
			icon = "",
			color = colors.gray,
			name = "Csh",
		},
		["css"] = {
			icon = "",
			color = colors.blue,
			name = "Css",
		},
		["csv"] = {
			icon = "",
			color = colors.green,
			name = "Csv",
		},
		["cxx"] = {
			icon = "",
			color = colors.blue,
			name = "Cxx",
		},
		["db"] = {
			icon = "",
			color = colors.red,
			name = "Db",
		},
		["desktop"] = {
			icon = "",
			color = colors.light,
			name = "DesktopEntry",
		},
		["diff"] = {
			icon = "",
			color = colors.magenta,
			name = "Diff",
		},
		["doc"] = {
			icon = "",
			color = colors.blue,
			name = "Doc",
		},
		["dockerfile"] = {
			icon = "",
			color = colors.blue,
			name = "Dockerfile",
		},
		["dropbox"] = {
			icon = "",
			color = colors.blue,
			name = "Dropbox",
		},
		["favicon.ico"] = {
			icon = "",
			color = colors.yellow,
			name = "Favicon",
		},
		["fnl"] = {
			color = colors.white,
			icon = "🌜",
			name = "Fennel"
		},
		["fish"] = {
			icon = "",
			color = colors.gray,
			name = "Fish",
		},
		["gif"] = {
			icon = "",
			color = colors.magenta,
			name = "Gif",
		},
		["git"] = {
			icon = "",
			color = colors.orange,
			name = "GitLogo",
		},
		["go"] = {
			icon = "",
			color = colors.blue,
			name = "Go",
		},
		["h"] = {
			icon = "",
			color = colors.cyan,
			name = "H",
		},
		["hh"] = {
			icon = "",
			color = colors.cyan,
			name = "Hh",
		},
		["hpp"] = {
			icon = "",
			color = colors.cyan,
			name = "Hpp",
		},
		["hs"] = {
			icon = "",
			color = colors.magenta,
			name = "Hs",
		},
		["htm"] = {
			icon = "",
			color = colors.orange,
			name = "Htm",
		},
		["html"] = {
			icon = "",
			color = colors.orange,
			name = "Html",
		},
		["hxx"] = {
			icon = "",
			color = colors.cyan,
			name = "Hxx",
		},
		["ico"] = {
			icon = "",
			color = colors.yellow,
			name = "Ico",
		},
		["import"] = {
			icon = "",
			color = colors.white,
			name = "ImportConfiguration",
		},
		["ini"] = {
			icon = "",
			color = colors.orange,
			name = "Ini",
		},
		["java"] = {
			icon = "",
			color = colors.dark_gray,
			name = "Java",
		},
		["jpeg"] = {
			icon = "",
			color = colors.magenta,
			name = "Jpeg",
		},
		["jpg"] = {
			icon = "",
			color = colors.magenta,
			name = "Jpg",
		},
		["js"] = {
			icon = "",
			color = colors.orange,
			name = "Js",
		},
		["json"] = {
			icon = "",
			color = colors.light,
			name = "Json",
		},
		["json5"] = {
			icon = "ﬥ",
			color = colors.light,
			name = "Json5",
		},
		["jsx"] = {
			icon = "",
			color = colors.blue,
			name = "Jsx",
		},
		["license"] = {
			icon = "",
			color = colors.yellow,
			name = "License",
		},
		["makefile"] = {
			icon = "",
			color = colors.light,
			name = "Makefile",
		},
		["md"] = {
			icon = "",
			color = colors.white,
			name = "Md",
		},
		["mustache"] = {
			icon = "",
			color = colors.orange,
			name = "Mustache",
		},
		["node_modules"] = {
			icon = "",
			color = colors.red,
			name = "NodeModules",
		},
		['package.json'] = {
			icon = "",
			color = colors.red,
			name = "PackageJson"
		},
		['package-lock.json'] = {
			icon = "",
			color = colors.dark_gray,
			name = "PackageLockJson"
		},
		["pdf"] = {
			icon = "",
			color = colors.red,
			name = "Pdf",
		},
		["png"] = {
			icon = "",
			color = colors.magenta,
			name = "Png",
		},
		["ppt"] = {
			icon = "",
			color = colors.orange,
			name = "Ppt",
		},
		["ps1"] = {
			icon = "",
			color = colors.gray,
			name = "PromptPs1",
		},
		["py"] = {
			icon = "",
			color = colors.yellow,
			name = "Py",
		},
		["sh"] = {
			icon = "",
			color = colors.gray,
			name = "Sh",
		},
		["sql"] = {
			icon = "",
			color = colors.red,
			name = "Sql",
		},
		["sqlite"] = {
			icon = "",
			color = colors.red,
			name = "Sql",
		},
		["sqlite3"] = {
			icon = "",
			color = colors.red,
			name = "Sql",
		},
		["svg"] = {
			icon = "ﰟ",
			color = colors.special,
			name = "Svg",
		},
		["terminal"] = {
			icon = "",
			color = colors.green,
			name = "Terminal",
		},
		["toml"] = {
			icon = "",
			color = colors.orange,
			name = "Toml",
		},
		["txt"] = {
			icon = "",
			color = colors.light,
			cterm_color = "0",
			name = "Txt",
		},
		["vim"] = {
			icon = "",
			color = colors.green,
			name = "Vim",
		},
		["webp"] = {
			icon = "",
			color = colors.magenta,
			name = "Webp",
		},
		["xml"] = {
			icon = "謹",
			color = colors.green,
			name = "Xml",
		},
		["yaml"] = {
			icon = "",
			color = colors.orange,
			name = "Yaml",
		},
		["yml"] = {
			icon = "",
			color = colors.orange,
			name = "Yml",
		},
		["zsh"] = {
			icon = "",
			color = colors.gray,
			name = "Zsh",
		},
		[".env"] = {
			icon = "",
			color = colors.cyan,
			name = "Env",
		},
		["lock"] = {
			icon = "",
			color = colors.dark_gray,
			name = "Lock",
		},
		["log"] = {
			icon = "",
			color = colors.white,
			name = "Log",
		},
	}

	local default_icon = {
		icon = "",
		color = colors.gray,
	}

	return override
end

return {
	"nvim-tree/nvim-web-devicons",
	dependencies = { 'nvim-base16' },
	config = function()
		require 'nvim-web-devicons'.set_icon(setup_base16())
	end,
}
