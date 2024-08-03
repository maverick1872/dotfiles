-- awesome_mode: api-level=4:screen=on

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Error handling
require("errorHandling")

-- Standard awesome library
require("awful.autofocus")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local vars = require("custom/variables")

-- Initialize theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "/themes/" .. vars.theme .. "theme.lua")

require("notifications")
require("clients")
require("screen")

-- Set Global Keybindings
require("keybinds")

-- Set Rules
require("custom/rules")

-- Set Signals
require("custom/signals")

-- Auto-started applications
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

-- Reduce memory consumption
collectgarbage("incremental", 150, 600, 0)
gears.timer.start_new(60, function()
	collectgarbage("collect")
	return true
end)
