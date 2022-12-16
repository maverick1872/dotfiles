local awful = require("awful")
local gears = require("gears")

local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t)
    t:view_only()
  end)
)

return function(s)
  return awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons
  }
end