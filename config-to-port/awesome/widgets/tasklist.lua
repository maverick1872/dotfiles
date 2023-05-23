local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function(c)
    c:emit_signal(
      "request::activate",
      "tasklist.lua",
      { raise = true }
    )
  end)
)

return function(s)
  return awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    style = {
      shape_border_width = 1,
      shape_border_color = '#777777',
      shape = gears.shape.rounded_rect,
    },
    layout = {
      spacing = 10,
      max_widget_size = 250,
      layout = wibox.layout.flex.horizontal
    },

    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      {
        {
          {
            {
              id = 'icon_role',
              widget = wibox.widget.imagebox,
            },
            margins = 1,
            widget = wibox.container.margin,
          },
          {
            id = 'text_role',
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left = 5,
        right = 5,
        widget = wibox.container.margin
      },
      id = 'background_role',
      widget = wibox.container.background,
    },
  }
end