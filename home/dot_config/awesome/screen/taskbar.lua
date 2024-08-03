local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local vars = require("custom.variables")
local widgets = require("widgets")

local function createTaskBar(s)
	-- Create the wibox
	s.mywibox = awful.wibar({
		position = vars.taskbarLocation,
		screen = s,
		opacity = 0.85,
		shape = gears.shape.rounded_rect,
		margins = {
			bottom = 5,
			left = 10,
			right = 10,
		},
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		-- Left widgets
		{
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
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
			widgets.calendar,
			widgets.layout(s),
		},
	})
end

awful.screen.connect_for_each_screen(function(s)
	createTaskBar(s)
end)
