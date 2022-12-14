local awful = require("awful")
local vars = require("custom/variables")
local naughty = require("naughty")
-- Configure layouts
-- awful.layout.layouts = vars.layouts

-- Each screen has its own tag table that each individually have their own layouts.
local function set_tags_per_screen(s)
    primaryScreen = screen.primary
    id = s.index

    if (screen.count() == 1) then
      for i = 1, #vars.screens do
        if (vars.screens[i].primary) then
	  screenTags = vars.screens[i].tags
          screenLayouts = vars.screens[i].layouts
	end
      end
    else
      screenTags = vars.screens[s.index].tags
      screenLayouts = vars.screens[s.index].layouts
    end
    awful.tag(screenTags, s, screenLayouts)
end


awful.screen.connect_for_each_screen(function(s)
    set_tags_per_screen(s)
end)
