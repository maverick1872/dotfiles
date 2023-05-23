local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local mods = require("custom.variables").modifiers
local group = "Awesome Control"

awful.keyboard.append_global_keybindings({
  awful.key({ mods.super, }, "s",
    hotkeys_popup.show_help,
    { description = "show help", group = group }),

  awful.key({ mods.super, mods.ctrl }, "r",
    awesome.restart,
    { description = "reload awesome", group = group }),

  awful.key({ mods.super, mods.shift }, "q",
    awesome.quit,
    { description = "quit awesome", group = group }),

  awful.key({ mods.super, }, "w", function()
    mymainmenu:show()
    end, { description = "show main menu", group = group }),
})
