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

return config
