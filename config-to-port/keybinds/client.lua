local awful = require("awful")
local mods = require('custom.variables').modifiers
local group = "Client Control"

awful.keyboard.append_global_keybindings({
  awful.key({ mods.super, }, "j", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus next by index", group = group }),

  awful.key({ mods.super, }, "k", function()
    awful.client.focus.byidx(1)
  end, { description = "focus previous by index", group = group }),

  -- Layout manipulation
  awful.key({ mods.super, "Shift" }, "j", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with next client by index", group = group }),

  awful.key({ mods.super, "Shift" }, "k", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with previous client by index", group = group }),

  awful.key({ mods.super, }, "u",
    awful.client.urgent.jumpto,
    { description = "jump to urgent client", group = group }),

  awful.key({ mods.super, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end, { description = "go back", group = group }),

  awful.key({ mods.super, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = group }),

})

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    awful.key({ mods.super, }, "f",
      function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end, { description = "toggle fullscreen", group = group }),
    
    awful.key({ mods.super, }, "q", function(c)
      c:kill()
      end, { description = "close", group = group }),
    
    awful.key({ mods.super, "Control" }, "space",
      awful.client.floating.toggle,
      { description = "toggle floating", group = group }),
    
    awful.key({ mods.super, "Control" }, "t", function(c)
      awful.titlebar.toggle(c)
      end, { description = "Toggle client titlebar", group = group }),
    
    awful.key({ mods.super, "Control" }, "Return", function(c)
      c:swap(awful.client.getmaster())
      end, { description = "move to master layout position", group = group }),
    
    awful.key({ mods.super, }, "o", function(c)
      c:move_to_screen(c.screen.index - 1)
      end, { description = "move to next screen", group = group }),
    
    awful.key({ mods.super, "Shift" }, "o", function(c)
      c:move_to_screen()
      end, { description = "move to previous screen", group = group }),
    
    awful.key({ mods.super, }, "t", function(c)
      c.ontop = not c.ontop
      end, { description = "toggle keep on top", group = group }),
    
    awful.key({ mods.super, }, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end, { description = "minimize", group = group }),
    
    awful.key({ mods.super, }, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
      end, { description = "(un)maximize", group = group }),
    
    awful.key({ mods.super, "Control" }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end, { description = "(un)maximize vertically", group = group }),
    
    awful.key({ mods.super, "Shift" }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end, { description = "(un)maximize horizontally", group = group }),
    
    awful.key({ mods.super, 'Control', 'Shift' }, "k", function()
      awful.client.incwfact(0.05)
      --awful.client.height = awful.client.height + 10
      end, { description = "increase client window factor", group = group }),
    
    awful.key({ mods.super, 'Control', 'Shift' }, "j", function()
      awful.client.incwfact(-0.05)
      --awful.client.height = awful.client.height - 10
      end, { description = "decrease client window factor", group = group }),
  })
end)

--- MOUSE KEYBINDINGS ---
client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings({
    awful.button({ }, 1, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ mods.super }, 1, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({ mods.super }, 3, function(c)
      c:emit_signal("request::activate", "mouse_click", { raise = true })
      awful.mouse.client.resize(c)
    end),
  })
end)