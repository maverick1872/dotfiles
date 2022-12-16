local awful = require("awful")
local wibox = require("wibox")
local vars = require("custom.variables")
local widgets = require("widgets")

-- Want global clock instance so created outside of function
local clock = wibox.widget.textclock()

local function createTaskBar(s)
  -- Create the wibox
  s.mywibox = awful.wibar({ position = vars.taskbarLocation, screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    -- Left widgets
    {
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      widgets.taglist(s),
    },
    -- Middle widgets
    {
      layout = wibox.layout.fixed.horizontal,
      widgets.tasklist(s),
    },
    -- Right widgets
    {
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      wibox.widget.textclock(),
      clock,
      widgets.battery,
      widgets.layout(s),
    },
  }
end

awful.screen.connect_for_each_screen(function(s)
  createTaskBar(s)
end)
