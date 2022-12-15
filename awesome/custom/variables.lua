local modifiers = require("custom/modifiers")
local awful = require('awful')
local variables = {}

variables.modifier = modifiers.super
variables.themeDir = "${HOME}/.config/awesome/themes/"
variables.theme = "default/"
variables.themeStyle = "dark/"
variables.titlebarsEnabled = false
variables.tags = {
  { name = "Personal" },
  { name = "Work" },
  { name = "Random" },
  { name = "Games" },
}
variables.layouts = {
  awful.layout.suit.max,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile,
  awful.layout.suit.tile.top,
}
variables.screens = {
  {
    layouts = {
      awful.layout.suit.max,
      awful.layout.suit.tile,
    },
    tags = { "Personal", " Work", " Random", " Games" },
  },
  {
    layouts = {
      awful.layout.suit.max,
      awful.layout.suit.tile.bottom,
      awful.layout.suit.tile.top,
    },
    tags = { "Browsing", " Work", " Spotify" },
  },
  {
    layouts = {
      awful.layout.suit.max,
      awful.layout.suit.tile.bottom,
      awful.layout.suit.tile.top,
    },
    tags = { "Browsing", " Work", " Chat" },
  }
}
variables.defaultPrograms = {
  terminal = "kitty",
  editor = os.getenv("EDITOR") or "vim",
}
variables.autoStartedApplications = {
  "${HOME}/.config/awesome/autorun.sh"
}

return variables
