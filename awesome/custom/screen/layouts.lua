local awful = require("awful")
local vars = require("custom/variables")
local naughty = require("naughty")
-- Configure layouts
-- awful.layout.layouts = vars.layouts

-- Each screen has its own tag table that each individually have their own layouts.
local function set_tags_per_screen(s)
  id = s.index
  screenTags = vars.screens[id].tags
  screenLayouts = vars.screens[id].layouts

  for i, tagName in ipairs(screenTags) do
    awful.tag.add(tagName, {
      screen = s,
      layout = screenLayouts[1],
      layouts = screenLayouts
    }
end


awful.screen.connect_for_each_screen(function(s)
    set_tags_per_screen(s)
end)
