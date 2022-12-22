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

require('notifications')
require('clients')
require('screen')
local naughty = require("naughty")
naughty.notification({ title = 'some title', text = 'notification body' })
-- Set Global Keybindings
require("keybinds")

-- Set Rules
require('custom/rules')

-- Set Signals
require('custom/signals')

-- Auto-started applications
--awful.spawn.with_shell("$HOME/.config/awesome/autorun.sh")
awful.util.spawn_with_shell("xidlehook --not-when-audio --timer 600 'systemctl suspend' '' &")

-- Reduce memory consumption
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
gears.timer({
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    collectgarbage("collect")
  end,
})
