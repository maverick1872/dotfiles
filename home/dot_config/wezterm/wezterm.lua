local wezterm = require("wezterm")
local options = require("options")
local keys = require("keys")
local keytables = require("keytables")

-- Create a configuration for typed config errors
local config = wezterm.config_builder()

-- Apply the configuration modules
options.apply_to_config(config)
keys.apply_to_config(config)
-- Quirk: this relies on the keys being applied first
keytables.apply_to_config(config)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = string.format(" %s  %s ~ %s  ", "❯", utils.get_current_working_dir(tab))

	return {
		{ Text = title },
	}
end)

return config
