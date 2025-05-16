local wezterm = require("wezterm")
local utils = require("utils")

-- Create a configuration for typed config errors
local config = wezterm.config_builder()

-- Apply the configuration modules
require("options").apply_to_config(config)
require("option-overrides").apply_to_config(config)

require("keys").apply_to_config(config)
-- Quirk: this relies on the keys being applied first
require("keytables").apply_to_config(config)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = string.format(" %s  %s ~ %s  ", "❯", utils.get_current_working_dir(tab))

	return {
		{ Text = title },
	}
end)

return config
