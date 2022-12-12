-- awesome_mode: api-level=4:screen=on

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Custom Variables
local vars = require("custom/variables")

-- Error handling
require("errorHandling").handleErrors()

-- Initialize theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "/themes/" .. vars.theme .. "theme.lua")

require('custom/screen/wallpaper')

-- Configure layouts
awful.layout.layouts = vars.layouts

-- Configure Wibar
require("custom/wibar").configure()

-- Set Global Keybindings
root.keys(require('custom/keyboard/global'))

-- Set Rules
awful.rules.rules = require('custom/rules')

-- Set Signals
require('custom/signals').configureSignals()

-- Auto-started applications
awful.spawn.with_shell("$HOME/.config/awesome/autorun.sh")
