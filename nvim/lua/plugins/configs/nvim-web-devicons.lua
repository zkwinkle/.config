local present, devicons = pcall(require, "nvim-web-devicons")

if not present then
	return
end

--
--print("override txt icon: ", override.txt.icon)
--print("override txt name: ", override.txt.name)
--print("override txt color: ", override.txt.color)


--devicons.setup({ override = override,
--{
--	txt = {
--		icon = "",
--		name = "Txt",
--		color = "#B4B8C8"
--	},
--	log = {
--		icon = "",
--		color = "#0000FF",
--		cterm_color = "65",
--		name = "Log",
--	},
--},
--	color_icons = true,
--	default = true,
--})

--devicons.set_default_icon(default_icon)
