local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

-- Create an imagebox widget which will contain an icon indicating which layout we're using.
return function(s)
  local currentTag = awful.screen.focused().selected_tag
  local column_count_widget = wibox.widget.textbox(currentTag.column_count)
  local master_count_widget = wibox.widget.textbox(currentTag.master_count)
  local layoutWidget = awful.widget.layoutbox(s)

  --for _, tag in ipairs(s.tags) do
  --  tag.connect_signal("property::column_count", function(t)
  --    column_count_widget.text = " " .. tostring(t.column_count)
  --  end)
  --  tag.connect_signal("property::master_count", function(t)
  --    master_count_widget.text = " " .. tostring(t.master_count)
  --  end)
  --end


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

  return {
    layout = wibox.layout.fixed.horizontal,
    layoutWidget,
    --column_count_widget,
    --master_count_widget,
  }
end;