local awful = require("awful")
local group = "Media Control"

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ }, "XF86AudioRaiseVolume", function()
      awful.spawn("amixer -D pulse sset Master 5%+")
      end, { descriptions = "Raise Volume", group = group}),
    awful.key({ }, "XF86AudioLowerVolume", function()
      awful.spawn("amixer -D pulse sset Master 5%-")
      end, { descriptions = "Lower Volume", group = group}),
    awful.key({ }, "XF86AudioPlay", function()
      awful.spawn("playerctl --player=spotify,%any play-pause")
      end, { descriptions = "Play/Pause", group = group}),
    awful.key({ }, "XF86AudioNext", function()
      awful.spawn("playerctl --player=spotify,%any next")
      end, { descriptions = "Next track", group = group}),
    awful.key({ }, "XF86AudioPrev", function()
      awful.spawn("playerctl --player=spotify,%any previous")
      end, { descriptions = "Previous track", group = group}),
  })
end)