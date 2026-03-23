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
local gpus = wezterm.gui.enumerate_gpus()

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
  "Noto Color Emoji",
  { family = "Symbols Nerd Font Mono", scale = 0.75 },
})
config.color_scheme = "Catppuccin Mocha"
config.warn_about_missing_glyphs = false

-- fps and cursor
config.enable_wayland = true
config.max_fps = 120
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 0
config.animation_fps = 1
config.cursor_blink_rate = 0

-- scroll
config.enable_scroll_bar = false

-- gpu stuff
-- https://github.com/wez/wezterm/issues/2756
config.webgpu_preferred_adapter = gpus[1]
config.front_end = "WebGpu"
config.prefer_egl = true

-- general
config.term = "wezterm"
config.check_for_updates = false -- I tend to disable this when downloading WezTerm from a package manager.
config.audible_bell = "Disabled"
config.automatically_reload_config = false
config.window_close_confirmation = "NeverPrompt"

-- tab bar and window
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.window_decorations = "NONE"

config.hide_mouse_cursor_when_typing = true
config.use_ime = false

-- disable wezterm mappings are they are troublesome with neovim
config.disable_default_key_bindings = true

config.use_dead_keys = true -- do not expect another key after `^~`

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
