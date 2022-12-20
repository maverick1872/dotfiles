local awful = require("awful")
local vars = require("custom.variables")
local group = "Screen Control"

awful.keyboard.append_global_keybindings({
  awful.key({ vars.modifier, "Control" }, "j", function()
    awful.screen.focus_relative(1)
    end, { description = "focus the next screen", group = group }),

  awful.key({ vars.modifier, "Control" }, "k", function()
    awful.screen.focus_relative(-1)
    end, { description = "focus the previous screen", group = group }),
})