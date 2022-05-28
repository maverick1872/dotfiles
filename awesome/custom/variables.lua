local modifiers = require("custom/modifiers")
local awful = require('awful')
local variables = {}

variables.modifier = modifiers.super
variables.themeDir = "${HOME}/.config/awesome/themes/"
variables.theme = "default/"
variables.themeStyle = "dark/"
variables.titlebarsEnabled = false
variables.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.floating,
    awful.layout.suit.corner.nw,
}
variables.defaultPrograms = {
    terminal = "kitty",
    editor = os.getenv("EDITOR") or "vim",
}
variables.autoStartedApplications = {
    "${HOME}/.config/awesome/autorun.sh"
}

return variables