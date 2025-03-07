local wezterm = require("wezterm")
local action = wezterm.action

local module = {}

function module.apply_to_config(config)
	-- TODO: this needs to be updated to insert rather than override the table?
	config.keys = {

		{ mods = "CTRL", key = "X", action = action.ActivateCopyMode },
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ mods = "OPT", key = "LeftArrow", action = action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ mods = "OPT", key = "RightArrow", action = action({ SendString = "\x1bf" }) },
		-- Make Cmd-Left/Right equivalent to Home/End
		{ mods = "CMD", key = "LeftArrow", action = action({ SendString = "\x1bOH" }) },
		{ mods = "CMD", key = "RightArrow", action = action({ SendString = "\x1bOF" }) },
		{ mods = "CMD", key = "R", action = action.ReloadConfiguration },
		{ mods = "CMD", key = "K", action = action.ClearScrollback("ScrollbackAndViewport") },

		{ mods = "LEADER", key = "4", action = action({ SpawnCommandInNewTab = { cwd = wezterm.home_dir } }) },
	}
end

return module
