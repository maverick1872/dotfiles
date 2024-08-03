local wibox = require("wibox")
local calendar_widget = require("external-widgets.calendar-widget.calendar")

-- Create a textclock widget to attach the calendar popup to
local calendar = wibox.widget.textclock()

local cw = calendar_widget({
	placement = "bottom_right",
	start_sunday = true,
	radius = 8,
	week_numbers = true,
	previous_month_button = 1,
	next_month_button = 3,
	auto_hide = true,
	timeout = 3,
})

calendar:connect_signal("button::press", function(_, _, _, button)
	if button == 1 then
		cw.toggle()
	end
end)

return calendar
