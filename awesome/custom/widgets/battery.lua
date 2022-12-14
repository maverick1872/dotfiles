local awful = require("awful")
local naughty = require("naughty")

-- local icon_widget = wibox.widget {
--   {
--     id = "icon",
--     widget = wibox.widget.imagebox,
--     resize = false
--   },
--   valign = 'center',
--   layout = wibox.container.place,
-- }
-- 
-- local level_widget = wibox.widget {
-- --  font = font,
--   widget = wibox.widget.textbox
-- }
-- 
-- local wrapper = wibox.widget {
--   icon_widget,
--   level_widget,
--   layout = wibox.layout.fixed.horizontal,
-- }
local textStatus = awful.widget.watch(
  'cat /sys/class/power_supply/BAT1/capacity',
  90,
  function(widget, stdout)
    local percent = string.gsub(stdout, "\n", "")
    naughty.notify({text = 'updating bat: '..percent.."%"})
    widget:set_text(percent.."%")
  end
)

return textStatus
--return wibox.widget {
--  markup = 'battery percent',
--  valign = 'center',
--  align = 'center',
--  widget = wibox.widget.textbox
--}
