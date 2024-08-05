local wezterm = require("wezterm")
local utils = require("utils")

local module = {}

function module.apply_to_config(config)
	config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }
	config.window_padding = {
		left = 0,
		right = 0,
		top = 10,
		bottom = 0,
	}
	config.default_workspace = "~"
	config.use_fancy_tab_bar = true
	config.inactive_pane_hsb = {
		brightness = 0.8,
	}
	config.scrollback_lines = 2000
	config.audible_bell = "Disabled"
	config.enable_scroll_bar = true
	config.status_update_interval = 1000
	config.color_scheme = "One Dark (Gogh)"
	config.colors = wezterm.color.get_builtin_schemes()[config.color_scheme]

	-- must come after setting the color scheme
	utils.create_tab_bar_colorscheme(config)
end

return module
