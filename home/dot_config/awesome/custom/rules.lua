local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
  },

  -- Floating clients.
  {
    rule_any = {
      type = {
        "dialog",
        "override",
      },
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
        "xtightvncviewer",
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
        "Steam - News",
        "Welcome to IntelliJ IDEA",
        "History for Selection",
        "splash",
        "Polls/Quizzes"
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
      titlebars_enabled = true
    }
  },

  -- Floating but have built in titlebar
  {
    rule_any = {
      class = {
        "peek",
      },
      name = {
        "Peek",
      },
    },
    properties = {
      callback = function(c)
        naughty.notify({text = "Hiding peek's titlebar"})
        awful.titlebar.hide(c)
      end
    }
  },

  -- Games!
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
      fullscreen = true,
      screen = 1
      --maximized_vertical = true,
      --maximized_horizontal = true
    }
  },

  -- Steam
  {
    rule_any = {
      name = {
        "Steam"
      },
      class = {
        "Steam"
      }
    },
    properties = {
      tag = "Games",
      screen = 2,
    }
  },

  -- Discord
  {
    rule_any = {
      name = {
        "discord"
      },
      class = {
        "discord"
      }
    },
    properties = {
      screen = 3,
      tag = screen[3].tags[3],
    }
  },

  -- Signal
  {
    rule_any = {
      instance = {
        "Signal"
      },
      class = {
        "Signal"
      }
    },
    properties = {
      screen = 3,
      tag = screen[3].tags[3],
      floating = false,
    },
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
      tag = screen[3].tags[3],
      floating = false,
    },
  },
  -- Slack Mini Window
  -- {
  --   rule_any = {
  --     instance = {
  --       "slack"
  --     },
  --     class = {
  --       "Slack",
  --     }
  --   },
  --   properties = {
  --     floating = true,
  --   },
  --   callback = function(c)
  --     naughty.notify({text = "IDE was started on screen 1"})
  --     naughty.notify({text = c.type })
  --   end
  -- },

  -- Spotify
  {
    rule_any = {
      instance = {
        "spotify"
      },
      class = {
        "Spotify",
      }
    },
    properties = {
      screen = 2,
      -- tag = "Spotify",
      tag = screen[2].tags[3],
      floating = false,
    },
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
    },
    callback = function(c)
      naughty.notify({text = "IDE was started on screen 1"})
    end
  },

  --{
  --  rule_any = {
  --    class = {
  --      "jetbrains-idea"
  --    },
  --    instance = {
  --      "jetbrains-idea"
  --    },
  --    except_any = {
  --      type = {
  --        "dialog"
  --      },
  --      name = {
  --        "dotfiles.*",
  --        "erudite.*"
  --      }
  --    }
  --  },
  --  properties = {
  --    tag = "Work"
  --  }
  --},

  {
    rule_any = {
      class = {
        "jetbrains-idea"
      },
      instance = {
        "jetbrains-idea"
      },
      name = {
        "dotfile",
        "erudite"
      }
    },
    callback = function(c)
      naughty.notify({text = "personal project in idea was started"})
    end
  }
}
