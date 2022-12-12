local awful = require("awful")
local vars = require("custom/variables")

-- Configure layouts
--awful.layout.layouts = vars.layouts

-- Each screen has its own tag table that each individually have their own layouts.
local function set_tags_per_screen(s)
    screenTags = vars.screens.tags[s]
    screenLayouts = vars.screens.layouts[s]

    awful.tag(screenTags, s, screenLayouts)
end


awful.screen.connect_for_each_screen(function(s)
    set_tags_per_screen(s)
end)
