local awful = require("awful")
local vars = require("custom.variables")
local mods = require("custom.variables").modifiers
local group = "Layout Control"

awful.keyboard.append_global_keybindings({
  awful.key({ mods.super, }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = group }),

  awful.key({ mods.super, }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = group }),

  awful.key({ mods.super, mods.shift }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = group }),

  awful.key({ mods.super, mods.shift }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = group }),

  awful.key({ mods.super, mods.ctrl }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = group }),

  awful.key({ mods.super, mods.ctrl }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = group }),

  awful.key({ mods.super, }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = group }),

  awful.key({ mods.super, mods.shift }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = group }),
})
