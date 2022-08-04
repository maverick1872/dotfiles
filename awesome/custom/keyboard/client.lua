local awful = require('awful')
local gears = require("gears")
local vars = require("custom/variables")

return gears.table.join(
        awful.key({ vars.modifier, }, "f",
                function(c)
                    c.fullscreen = not c.fullscreen
                    c:raise()
                end,
                { description = "toggle fullscreen", group = "client" }),
        awful.key({ vars.modifier, }, "q", function(c)
            c:kill()
        end,
                { description = "close", group = "client" }),
        awful.key({ vars.modifier, "Control" }, "space", awful.client.floating.toggle,
                { description = "toggle floating", group = "client" }),
        awful.key({ vars.modifier, "Control" }, "t", function(c)
            awful.titlebar.toggle(c)
        end, { description = "Toggle client titlebar", group = "client" }),
        awful.key({ vars.modifier, "Control" }, "Return", function(c)
            c:swap(awful.client.getmaster())
        end,
                { description = "move to master layout position", group = "client" }),
        awful.key({ vars.modifier, }, "o", function(c)
            c:move_to_screen()
        end,
                { description = "move to next screen", group = "client" }),
        awful.key({ vars.modifier, "Shift" }, "o", function(c)
            c:move_to_screen(c.screen.index - 1)
        end,
                { description = "move to previous screen", group = "client" }),
        awful.key({ vars.modifier, }, "t", function(c)
            c.ontop = not c.ontop
        end,
                { description = "toggle keep on top", group = "client" }),
        awful.key({ vars.modifier, }, "n",
                function(c)
                    -- The client currently has the input focus, so it cannot be
                    -- minimized, since minimized clients can't have the focus.
                    c.minimized = true
                end,
                { description = "minimize", group = "client" }),
        awful.key({ vars.modifier, }, "m",
                function(c)
                    c.maximized = not c.maximized
                    c:raise()
                end,
                { description = "(un)maximize", group = "client" }),
        awful.key({ vars.modifier, "Control" }, "m",
                function(c)
                    c.maximized_vertical = not c.maximized_vertical
                    c:raise()
                end,
                { description = "(un)maximize vertically", group = "client" }),
        awful.key({ vars.modifier, "Shift" }, "m",
                function(c)
                    c.maximized_horizontal = not c.maximized_horizontal
                    c:raise()
                end,
                { description = "(un)maximize horizontally", group = "client" }),
        awful.key({ vars.modifier, 'Control', 'Shift' }, "k", function()
            awful.client.incwfact(0.05)
        end,
                { description = "increase client window factor", group = "client" }),
        awful.key({ vars.modifier, 'Control', 'Shift' }, "j", function()
            awful.client.incwfact(-0.05)
        end,
                { description = "decrease client window factor", group = "client" }),

        awful.key({ }, "XF86AudioRaiseVolume", function() awful.spawn("amixer -D pulse sset Master 5%+") end),
        awful.key({ }, "XF86AudioLowerVolume", function() awful.spawn("amixer -D pulse sset Master 5%-") end),
        awful.key({ }, "XF86AudioPlay", function() awful.spawn("playerctl play-pause") end),
        awful.key({ }, "XF86AudioNext", function() awful.spawn("playerctl next") end),
        awful.key({ }, "XF86AudioPrev", function() awful.spawn("playerctl previous") end)
)