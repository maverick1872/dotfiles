local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local vars = require("custom/variables")

local wibar = {}

wibar.configure = function()
  mytextclock = wibox.widget.textclock()

  -- Create a wibox for each screen and add it
  local taglist_buttons = gears.table.join(
      awful.button({ }, 1, function(t)
        t:view_only()
      end)
  )

  local tasklist_buttons = gears.table.join(
      awful.button({ }, 1, function(c)
        c:emit_signal(
            "request::activate",
            "tasklist",
            { raise = true }
        )
      end)
  )

  awful.screen.connect_for_each_screen(function(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
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
        end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
      screen = s,
      filter = awful.widget.taglist.filter.all,
      buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
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

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        s.mytaglist,
        s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        mykeyboardlayout,
        wibox.widget.systray(),
        mytextclock,
        s.mylayoutbox,
      },
    }
  end)
end

return wibar