local awful = require("awful")
local beautiful = require("beautiful")

return {
  -- All clients will match this rule.
  { rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = require('custom/keyboard/client'),
      buttons = require('custom/mouse/client'),
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA", -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin", -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer"
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
        "Steam - News",
        "Welcome to IntelliJ IDEA",
        "splash"
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      }
    },
    properties = {
      floating = true,
      placement = awful.placement.centered,
    }
  },

  -- Add Titlebars
  {
    rule_any = {
      type = {
        "normal",
        "dialog"
      }
    },
    properties = {
      titlebars_enabled = true
    }
  },


  -- Games
  {
    rule_any = {
      class = {
        "steam_app_252950", -- Rocket League
        "steam_app_1172470", -- Apex Legends
        "steam_app_.*"
      }
    },
    properties = {
      tag = "Games",
      titlebars_enabled = false,
      maximized_vertical = true,
      maximized_horizontal = true
    }
  },

  -- Slack
  {
    rule_any = {
      instance = {
        "slack"
      },
      class = {
        "Slack",
      }
    },
    properties = {
      screen = 3,
      tag = "Work",
      floating = false,
      fullscreen = false
    }
  },

  -- IDE Settings
  {
    rule_any = {
      class = {
        "jetbrains-idea"
      },
      instance = {
        "jetbrains-idea"
      }
    },
    properties = {
      screen = 1,
    }
  },

  {
    rule_any = {
      except_any = {
        name = {
          "dotfiles.*",
          "erudite.*"
        }
      }
    },
    properties = {
      tag = "Work"
    }
  },

  {
    rule_any = {
      name = {
        "dotfiles.*",
        "erudite.*"
      }
    },
    properties = {
      tag = "Personal"
    }
  }
}