--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

require("links").setup(config)

-- Use the defaults as a base
config.hyperlink_rules = wezterm.default_hyperlink_rules()
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'Batman'
config.line_height = 1.1
config.font_size = 10
config.font = wezterm.font_with_fallback({
	{ family = "MonoLisa Nerd Font", weight = "Regular" },
	{ family = "DejaVuSansM Nerd Font", weight = "Regular" },
})
config.color_scheme = "Catppuccin Mocha"

config.enable_wayland = true

config.max_fps = 120

-- scroll
config.enable_scroll_bar = false


-- general
config.window_background_opacity = 0.88
config.initial_rows = 41
config.initial_cols = 160
config.term = "wezterm"
config.check_for_updates = false -- I tend to disable this when downloading WezTerm from a package manager.
-- tab bar and window
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

-- disable wezterm mappings are they are troublesome with neovim
config.disable_default_key_bindings = true
config.enable_wayland = true

-- core keymaps that are general
config.keys = {
	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "+",
		mods = "CTRL|SHIFT",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "-",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DecreaseFontSize,
	},
}

return config
