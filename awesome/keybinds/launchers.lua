local awful = require("awful")
local vars = require("custom.variables")
local mods = require("custom.variables").modifiers
local defaultApps = require("custom.variables").defaultPrograms
local group = "Application Launchers"

awful.keyboard.append_global_keybindings({
  awful.key({ mods.super, }, "Return", function()
    awful.spawn(defaultApps.terminal)
    end, { description = "Terminal", group = group }),

  awful.key({ vars.modifier }, "r", function()
    awful.util.spawn("rofi -show combi")
    end, { description = "Show Rofi", group = group }),

  awful.key({ }, "Print", function()
    awful.spawn("flameshot gui -d 1000")
    end, { description = "Screenshot", group = group }),

  awful.key({ mods.shift }, "Print", function()
    awful.spawn("peek")
    end, { description = "Screen Recorder", group = group }),
})
