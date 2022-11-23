local awful = require('awful')
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local vars = require("custom/variables")
require("awful.hotkeys_popup.keys")

local globalKeys = gears.table.join(
    awful.key({ vars.modifier, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),
    awful.key({ vars.modifier, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ vars.modifier, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ vars.modifier, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),
    awful.key({ vars.modifier, }, "j",
        function()
          awful.client.focus.byidx(-1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ vars.modifier, }, "k",
        function()
          awful.client.focus.byidx(1)
        end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key({ vars.modifier, }, "w", function()
      mymainmenu:show()
    end,
        { description = "show main menu", group = "awesome" }),

-- Layout manipulation
    awful.key({ vars.modifier, "Shift" }, "j", function()
      awful.client.swap.byidx(-1)
    end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ vars.modifier, "Shift" }, "k", function()
      awful.client.swap.byidx(1)
    end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ vars.modifier, "Control" }, "j", function()
      awful.screen.focus_relative(1)
    end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ vars.modifier, "Control" }, "k", function()
      awful.screen.focus_relative(-1)
    end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ vars.modifier, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ vars.modifier, }, "Tab",
        function()
          awful.client.focus.history.previous()
          if client.focus then
            client.focus:raise()
          end
        end,
        { description = "go back", group = "client" }),

-- Standard program
    awful.key({ vars.modifier, }, "Return", function()
      awful.spawn(vars.defaultPrograms.terminal)
    end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ vars.modifier, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ vars.modifier, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),
    awful.key({ }, "Print", function()
      awful.spawn("flameshot gui")
    end, { description = "Take screenshot", group = "launcher" }),
    awful.key({ "Shift" }, "Print", function()
      awful.spawn("peek")
    end,
        { description = "Take screen recording", group = "launcher" }),

    awful.key({ vars.modifier, }, "l", function()
      awful.tag.incmwfact(0.05)
    end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ vars.modifier, }, "h", function()
      awful.tag.incmwfact(-0.05)
    end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ vars.modifier, "Shift" }, "h", function()
      awful.tag.incnmaster(1, nil, true)
    end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ vars.modifier, "Shift" }, "l", function()
      awful.tag.incnmaster(-1, nil, true)
    end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ vars.modifier, "Control" }, "h", function()
      awful.tag.incncol(1, nil, true)
    end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ vars.modifier, "Control" }, "l", function()
      awful.tag.incncol(-1, nil, true)
    end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ vars.modifier, }, "space", function()
      awful.layout.inc(1)
    end,
        { description = "select next", group = "layout" }),
    awful.key({ vars.modifier, "Shift" }, "space", function()
      awful.layout.inc(-1)
    end,
        { description = "select previous", group = "layout" }),

    awful.key({ vars.modifier, "Control" }, "n",
        function()
          local c = awful.client.restore()
          -- Focus restored client
          if c then
            c:emit_signal(
                "request::activate", "key.unminimize", { raise = true }
            )
          end
        end,
        { description = "restore minimized", group = "client" }),

-- Prompt
    awful.key({ vars.modifier }, "r",
        function()
          awful.util.spawn("rofi -show combi")
        end,
        { description = "Show Rofi", group = "launcher" }),

    awful.key({ vars.modifier }, "x",
        function()
          awful.prompt.run {
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
          }
        end,
        { description = "lua execute prompt", group = "awesome" }),
-- Menubar
    awful.key({ vars.modifier }, "p", function()
      menubar.show()
    end,
        { description = "show the menubar", group = "launcher" })
)

for i = 1, #vars.tags do
  globalKeys = gears.table.join(globalKeys,
  -- View tag only.
      awful.key({ vars.modifier }, "#" .. i + 9,
          function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
              tag:view_only()
            end
          end,
          { description = "view tag N", group = "tag" }),
  -- Toggle tag display.
      awful.key({ vars.modifier, "Control" }, "#" .. i + 9,
          function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
              awful.tag.viewtoggle(tag)
            end
          end,
          { description = "toggle tag N", group = "tag" }),
  -- Move client to tag.
      awful.key({ vars.modifier, "Shift" }, "#" .. i + 9,
          function()
            if client.focus then
              local tag = client.focus.screen.tags[i]
              if tag then
                client.focus:move_to_tag(tag)
              end
            end
          end,
          { description = "move focused client to tag N", group = "tag" }),
  -- Toggle tag on focused client.
      awful.key({ vars.modifier, "Control", "Shift" }, "#" .. i + 9,
          function()
            if client.focus then
              local tag = client.focus.screen.tags[i]
              if tag then
                client.focus:toggle_tag(tag)
              end
            end
          end,
          { description = "toggle focused client on tag N", group = "tag" })
  )
end

return globalKeys