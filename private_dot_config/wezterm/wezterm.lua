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

config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.7,
}

config.max_fps = 120

-- scroll
config.scrollback_lines = 10000
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

-- integration with nvim and zen-mode
-- https://github.com/folke/zen-mode.nvim?tab=readme-ov-file#wezterm
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

config.freetype_load_target = "HorizontalLcd"
config.debug_key_events = true
-- and finally, return the configuration to wezterm
local theme_switcher = function(window, pane)
	-- get builting color schemes
	local schemes = wezterm.get_builtin_color_schemes()
	local choices = {}
	local config_path = os.getenv("XDG_CONFIG_HOME") .. "/wezterm/wezterm.lua"

	-- populate theme names in choices list
	for key, _ in pairs(schemes) do
		table.insert(choices, { label = tostring(key) })
	end

	-- sort choices list
	table.sort(choices, function(c1, c2)
		return c1.label < c2.label
	end)

	window:perform_action(
		act.InputSelector({
			title = "🎨 Pick a Theme!",
			choices = choices,
			fuzzy = true,

			-- execute 'sed' shell command to replace the line
			-- responsible of colorscheme in my config
			action = wezterm.action_callback(function(inner_window, inner_pane, _, label)
				inner_window:perform_action(
					act.SpawnCommandInNewTab({
						args = {
							"sed",
							"-i",
							'/^Colorscheme/c\\Colorscheme = "' .. label .. '"',
							config_path,
						},
					}),
					inner_pane
				)
			end),
		}),
		pane
	)
end

return config
