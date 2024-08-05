local wezterm = require("wezterm")
local module = {}

function module.create_tab_bar_colorscheme(config)
	local color_scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
	config.colors.tab_bar = { new_tab = {}, active_tab = {}, inactive_tab = {}, inactive_tab_hover = {} }

	config.colors.tab_bar.background = color_scheme.background

	config.colors.tab_bar.new_tab.fg_color = color_scheme.foreground
	config.colors.tab_bar.new_tab.bg_color = color_scheme.background

	config.colors.tab_bar.active_tab.fg_color = color_scheme.brights[8]
	config.colors.tab_bar.active_tab.bg_color = "#633C6E"
	config.colors.tab_bar.active_tab.intensity = "Bold"
	-- config.colors.tab_bar.active_tab.italic = false
	-- config.colors.tab_bar.active_tab.strikethrough = false
	-- config.colors.tab_bar.active_tab.underline = "Single"

	config.colors.tab_bar.inactive_tab.fg_color = color_scheme.foreground
	config.colors.tab_bar.inactive_tab.bg_color = color_scheme.background
	config.colors.tab_bar.inactive_tab.intensity = "Half"

	config.colors.tab_bar.inactive_tab_hover.fg_color = color_scheme.ansi[1]
	config.colors.tab_bar.inactive_tab_hover.bg_color = color_scheme.background

	config.colors.tab_bar.inactive_tab_edge = color_scheme.background

	-- 	config.window_frame = {
	-- 		inactive_titlebar_bg = color_scheme.background,
	-- 		active_titlebar_bg = color_scheme.background,
	-- 		inactive_titlebar_fg = color_scheme.foreground,
	-- 		active_titlebar_fg = color_scheme.foreground,
	-- 	},
	config.command_palette_bg_color = color_scheme.background
	-- 	config.command_palette_fg_color = color_scheme.foreground,
	-- 	config.char_select_bg_color = color_scheme.background,
	-- 	config.char_select_fg_color = color_scheme.tab_bar.active_tab.fg_color,
end

function module.basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function module.get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

	return current_dir == HOME_DIR and "." or string.gsub(current_dir, "(.*[/\\])(.*)", "%2")
end

return module
