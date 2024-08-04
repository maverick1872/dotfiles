local wezterm = require("wezterm")
local utils = require("utils")
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
local module = {}

function module.apply_to_config(config)
	modal.apply_to_config(config)

	wezterm.on("modal.enter", function(name, window, pane)
		modal.set_right_status(window, name)
		modal.set_window_title(pane, name)
	end)

	wezterm.on("modal.exit", function(_, window, pane)
		modal.reset_window_title(pane)
		window:set_right_status(wezterm.format({
			{ Text = utils.basename(window:active_workspace()) or "" },
		}))
	end)
end

return module
