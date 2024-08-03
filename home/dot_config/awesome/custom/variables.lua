local modifiers = require("custom/modifiers")
local awful = require("awful")

return {
	clientRadius = 10,
	modifier = modifiers.super,
	modifiers = {
		super = "Mod4",
		alt = "Mod1",
		shift = "Shift",
		ctrl = "Control",
	},
	themeDir = "${HOME}/.config/awesome/themes/",
	theme = "default/",
	themeStyle = "dark/",
	titlebarsEnabled = false,
	taskbarLocation = "bottom",
	screens = {
		{
			layouts = {
				awful.layout.suit.tile.bottom,
				awful.layout.suit.max,
				awful.layout.suit.tile.top,
			},
			tags = { "Personal", " Work", " Random", " Games" },
		},
		{
			layouts = {
				awful.layout.suit.max,
				awful.layout.suit.tile.bottom,
				awful.layout.suit.tile.top,
			},
			tags = { "Browsing", " Work", " Spotify" },
		},
		{
			layouts = {
				awful.layout.suit.tile.bottom,
				awful.layout.suit.max,
				awful.layout.suit.tile.top,
			},
			tags = { "Browsing", " Work", " Chat" },
		},
	},
	defaultPrograms = {
		terminal = "kitty",
		editor = os.getenv("EDITOR") or "vim",
	},
	autoStartedApplications = "${HOME}/.config/awesome/autorun.sh",
}
