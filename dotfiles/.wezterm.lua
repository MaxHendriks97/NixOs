local wezterm = require "wezterm"

local config = wezterm.config_builder()
config.default_prog = {"pwsh.exe"}
config.color_scheme = "Everforest Dark (Gogh)"
config.font = wezterm.font "Iosevka Nerd Font"

-- tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- key bindings
config.leader = { key = "a", mods = "CTRL" }
config.keys = {
	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action{ SendString = "\x01" }},
	{ key = "s", mods = "LEADER", action = wezterm.action{ SplitVertical = { domain = "CurrentPaneDomain" }}},
	{ key = "v", mods = "LEADER", action = wezterm.action{ SplitHorizontal = { domain = "CurrentPaneDomain" }}},
	{ key = "c", mods = "LEADER", action = wezterm.action{ SpawnTab = "CurrentPaneDomain" }},
	{ key = "LeftArrow", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Left" }},
	{ key = "DownArrow", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Down" }},
	{ key = "RightArrow", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Right" }},
	{ key = "UpArrow", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Up" }},
	{ key = "LeftArrow", mods = "LEADER|SHIFT", action = wezterm.action{ AdjustPaneSize = { "Left", 5 }}},
	{ key = "DownArrow", mods = "LEADER|SHIFT", action = wezterm.action{ AdjustPaneSize = { "Down", 5 }}},
	{ key = "RightArrow", mods = "LEADER|SHIFT", action = wezterm.action{ AdjustPaneSize = { "Right", 5 }}},
	{ key = "UpArrow", mods = "LEADER|SHIFT", action = wezterm.action{ AdjustPaneSize = { "Up", 5 }}},
	{ key = "1", mods = "LEADER", action = wezterm.action{ ActivateTab = 0 }},
	{ key = "2", mods = "LEADER", action = wezterm.action{ ActivateTab = 1 }},
	{ key = "3", mods = "LEADER", action = wezterm.action{ ActivateTab = 2 }},
	{ key = "4", mods = "LEADER", action = wezterm.action{ ActivateTab = 3 }},
	{ key = "5", mods = "LEADER", action = wezterm.action{ ActivateTab = 4 }},
	{ key = "6", mods = "LEADER", action = wezterm.action{ ActivateTab = 5 }},
	{ key = "7", mods = "LEADER", action = wezterm.action{ ActivateTab = 6 }},
	{ key = "8", mods = "LEADER", action = wezterm.action{ ActivateTab = 7 }},
	{ key = "9", mods = "LEADER", action = wezterm.action{ ActivateTab = 8 }},
	{ key = "0", mods = "LEADER", action = wezterm.action{ ActivateTab = 9 }},
	{ key = "&", mods = "LEADER|SHIFT", action = wezterm.action{ CloseCurrentTab = { confirm = true }}},
	{ key = "d", mods = "LEADER", action = wezterm.action{ CloseCurrentPane = { confirm = true }}},
	{ key = "x", mods = "LEADER", action = wezterm.action{ CloseCurrentPane = { confirm = true }}},
}

return config
