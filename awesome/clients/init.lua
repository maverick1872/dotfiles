-- local client = require("awful.client")
local gears = require("gears")

function set_corners(c)
  if c.maximized or c.fullscreen then
    c.shape = gears.shape.rectangle
  else
    c.shape = function(cr, w, h)
      gears.shape.rounded_rect(cr, w, h, 20)
    end
  end
end

client.connect_signal("request::manage", function(c)
  set_corners(c)
end)

client.connect_signal("property::fullscreen", function(c)
  set_corners(c)
end)

client.connect_signal("property::maximized", function(c)
  set_corners(c)
end)
