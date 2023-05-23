local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")
local widgets = require("widgets")
local utils = require("custom/utils")


-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Focus behavior
client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)

-- Better titlebar behavior
client.connect_signal("property::floating", function(c)
  utils.setTitlebar(c, c.floating or c.first_tag and c.first_tag.layout.name == "floating")
end)

-- Hook called when a client spawns
client.connect_signal("manage", function(c)
  utils.setTitlebar(c, c.floating or c.first_tag.layout == awful.layout.suit.floating)
end)

-- Show titlebars on tags with the floating layout
tag.connect_signal("property::layout", function(t)
  -- New to Lua ?
  -- pairs iterates on the table and return a key value pair
  -- I don't need the key here, so I put _ to ignore it
  for _, c in pairs(t:clients()) do
    if t.layout == awful.layout.suit.floating then
      utils.setTitlebar(c, true)
    else
      utils.setTitlebar(c, false)
    end
  end
end)
