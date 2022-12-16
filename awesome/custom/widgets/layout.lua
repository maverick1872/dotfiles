local awful = require("awful")
local gears = require("gears")

-- Create an imagebox widget which will contain an icon indicating which layout we're using.
return function(s)
  local layoutWidget = awful.widget.layoutbox(s)

  layoutWidget:buttons(gears.table.join(
    awful.button({ }, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({ }, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({ }, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({ }, 5, function()
      awful.layout.inc(-1)
    end)
  ))

  return layoutWidget
end