local awful = require("awful")
local beautiful = require("beautiful")
local utils = require("utils")

awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Floating clients.
	{
		rule_any = {
			type = {
				"dialog",
				"override",
			},
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer",
			},

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
				"Steam - News",
				"Welcome to IntelliJ IDEA",
				"History for Selection",
				"splash",
				"Polls/Quizzes",
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			},
		},
		properties = {
			floating = true,
			placement = awful.placement.centered,
			titlebars_enabled = true,
		},
	},

	-- Floating but have built in titlebar
	{
		rule_any = {
			class = {
				"peek",
				"gnome-calculator",
			},
			name = {
				"Peek",
				"Calculator",
			},
		},
		properties = {
			floating = true,
			titlebars_enabled = false,
			placement = awful.placement.centered,
			callback = function(c)
				utils.notify("Hiding titlebar for " .. c.name)
				awful.titlebar.hide(c)
			end,
		},
	},

	-- Games!
	{
		rule_any = {
			class = {
				"steam_app_252950", -- Rocket League
				"steam_app_1172470", -- Apex Legends
				"steam_app_.*",
			},
		},
		properties = {
			tag = "Games",
			titlebars_enabled = false,
			fullscreen = true,
			screen = 1,
			--maximized_vertical = true,
			--maximized_horizontal = true
		},
	},

	-- Steam
	{
		rule_any = {
			name = {
				"Steam",
			},
			class = {
				"Steam",
			},
		},
		properties = {
			screen = 3,
		},
	},

	-- Discord
	{
		rule_any = {
			name = {
				"discord",
			},
			class = {
				"discord",
			},
		},
		properties = {
			screen = 2,
			tag = "Chat",
		},
	},

	-- Signal
	{
		rule_any = {
			instance = {
				"Signal",
			},
			class = {
				"Signal",
			},
		},
		properties = {
			screen = 2,
			tag = "Chat",
			floating = false,
		},
	},

	-- Slack
	{
		rule_any = {
			instance = {
				"slack",
			},
			class = {
				"Slack",
			},
		},
		properties = {
			screen = 2,
			tag = "Chat",
			floating = false,
		},
	},

	-- Slack Mini Window
	-- {
	-- 	rule_any = {
	-- 		instance = {
	-- 			"slack",
	-- 		},
	-- 		class = {
	-- 			"Slack",
	-- 		},
	-- 	},
	-- 	properties = {
	-- 		floating = true,
	-- 	},
	-- 	callback = function(c)
	-- 		utils.notify("Making slack miniwindow floating")
	-- 		utils.notify(c.type)
	-- 	end,
	-- },

	-- Spotify
	{
		rule_any = {
			instance = {
				"spotify",
			},
			class = {
				"Spotify",
			},
		},
		properties = {
			screen = 3,
			tag = "Spotify",
			floating = false,
		},
	},
}

-- vim: expandtab:shiftwidth=2:tabstop=2:softtabstop=2:textwidth=80
