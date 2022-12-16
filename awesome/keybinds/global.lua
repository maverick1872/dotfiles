local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local vars = require('custom.variables')


awful.keyboard.append_global_keybindings({
  awful.key({ vars.modifier, }, "j", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus next by index", group = "client" }),

  awful.key({ vars.modifier, }, "k", function()
    awful.client.focus.byidx(1)
  end, { description = "focus previous by index", group = "client" }),

  -- Layout manipulation
  awful.key({ vars.modifier, "Shift" }, "j", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with next client by index", group = "client" }),

  awful.key({ vars.modifier, "Shift" }, "k", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with previous client by index", group = "client" }),

  awful.key({ vars.modifier, "Control" }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),

  awful.key({ vars.modifier, "Control" }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),

  awful.key({ vars.modifier, }, "u",
    awful.client.urgent.jumpto,
  { description = "jump to urgent client", group = "client" }),

  awful.key({ vars.modifier, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end, { description = "go back", group = "client" }),

  awful.key({ vars.modifier, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),

})