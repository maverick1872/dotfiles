-- awesome_mode: api-level=4:screen=on

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Error handling
require("errorHandling")

-- Standard awesome library
require("awful.autofocus")
local gears = require("gears")
local beautiful = require("beautiful")
local vars = require("custom/variables")

-- Initialize theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "/themes/" .. vars.theme .. "theme.lua")

require('clients')
require('screen')

-- Set Global Keybindings
require("keybinds")

-- Set Rules
require('custom/rules')

-- Set Signals
require('custom/signals')

-- Auto-started applications
--awful.spawn.with_shell("$HOME/.config/awesome/autorun.sh")

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

