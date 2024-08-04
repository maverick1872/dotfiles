local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	-- TODO: this needs to be updated to insert rather than override the table?
	config.keys = {
		{ key = "X", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
		-- Make Cmd-Left/Right equivalent to Home/End
		{ key = "LeftArrow", mods = "CMD", action = wezterm.action({ SendString = "\x1bOH" }) },
		{ key = "RightArrow", mods = "CMD", action = wezterm.action({ SendString = "\x1bOF" }) },
		{ key = "4", mods = "LEADER", action = wezterm.action({ SpawnCommandInNewTab = { cwd = wezterm.home_dir } }) },
	}
end

return module
