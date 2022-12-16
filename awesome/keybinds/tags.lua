local awful = require("awful")
local vars = require("custom.variables")
local mods = require("custom.variables").modifiers
local group = "Tag Control"

awful.keyboard.append_global_keybindings({
  awful.key({ mods.super, }, "Left",
    awful.tag.viewprev,
    { description = "view previous", group = group }),

  awful.key({ mods.super, }, "Right",
    awful.tag.viewnext,
    { description = "view next", group = group }),

   awful.key({ mods.super, }, "Escape",
     awful.tag.history.restore,
     { description = "go back", group = group }),
})


for i = 1, #vars.screens[1].tags do
  awful.keyboard.append_global_keybindings({
  -- View tag only.
    awful.key({ mods.super }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      { description = "view tag N", group = group }),
-- Toggle tag display.
    awful.key({ mods.super, mods.ctrl }, "#" .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      { description = "toggle tag N", group = group }),
-- Move client to tag.
    awful.key({ mods.super, mods.shift }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end,
      { description = "move focused client to tag N", group = group }),
-- Toggle tag on focused client.
    awful.key({ mods.super, mods.ctrl, mods.shift }, "#" .. i + 9,
      function()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end,
      { description = "toggle focused client on tag N", group = group })
  })
end