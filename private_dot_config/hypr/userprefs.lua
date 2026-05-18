-- Personal Hyprland Lua config migrated from userprefs.conf
-- Docs: https://wiki.hypr.land/Configuring/Start/

-------------------------------
-- Environment and base config
-------------------------------

hl.env("GDK_SCALE", "1")

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

hl.monitor({
	output = "eDP-1",
	mode = "highres",
	position = "auto",
	scale = "1",
})

------------
-- Input
------------

hl.config({
	input = {
		kb_options = "caps:escape",
		kb_layout = "us",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
		},
		sensitivity = 0,
		force_no_accel = true,
	},
})(
[[
#   "1": " ",
#   "2": " ",
#   "3": " ",
#   "4": " ",
#   "5": " ",
#   "6": " ",
#   "7": "",
#   "8": " ",
#   "9": "",
#   "10": "10",
#   "focused": "",
#   "default": "",
]])

----------------
-- Custom apps
----------------
hl.on("hyprland.start", function()
	-- Matches old `exec = ...` behavior (runs on config load/reload).
	hl.exec_cmd("sleep 5; ~/.config/tsumiki/init.sh -start")

	-- Matches old `exec-once = ...` startup behavior.
	hl.on("hyprland.start", function()
		hl.exec_cmd("sleep 5; safeeyes -e")
	end)
end)

----------------
-- Window rules
----------------

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "disable-blur-xwayland-context-menus",
	match = { class = "^()$", title = "^()$" },
	no_blur = true,
})

hl.window_rule({
	name = "disable-blur-every-window",
	match = { class = ".*" },
	no_blur = true,
})

hl.window_rule({
	name = "mpv-rules",
	match = { class = "^(.*mpv.*)" },
	float = true,
	center = true,
	size = { "monitor_w*0.7", "monitor_h*0.7" },
})

hl.window_rule({
	name = "dolphin-dialogs",
	match = {
		class = "^(org.kde.dolphin)$",
		title = "^(Copying - Dolphin)$|^(Progress Dialog - Dolphin)$",
	},
	size = { 600, 250 },
})

hl.window_rule({
	name = "zathura-rules",
	match = { class = "^(.*zathura.*)$" },
	float = true,
	center = true,
	size = { "monitor_w*0.45", "monitor_h*0.9" },
})

hl.window_rule({
	name = "stacer-rules",
	match = { class = "^(.*stacer.*)$" },
	float = true,
	center = true,
	size = { "monitor_w*0.45", "monitor_h*0.6" },
})

hl.window_rule({
	name = "kcalc-rules",
	match = { class = "^(org.kde.kcalc)$" },
	float = true,
	center = true,
	size = { 500, 700 },
})

hl.window_rule({
	name = "missioncenter-rules",
	match = { class = "^(io.missioncenter.MissionCenter)$" },
	float = true,
	center = true,
	size = { 700, 600 },
})

hl.window_rule({
	name = "persepolis-rules",
	match = { class = "^(com.github.persepolisdm.persepolis)$" },
	float = true,
	center = true,
	size = { "monitor_w*0.5", "monitor_h*0.5" },
	workspace = "special",
})

hl.window_rule({
	name = "persepolis-add-link-size",
	match = {
		class = "^(com.github.persepolisdm.persepolis)$",
		title = "^(Add Download Link)$",
	},
	size = { 800, 500 },
})

hl.window_rule({
	name = "ktorrent-rules",
	match = { class = "^(org.kde.ktorrent)$" },
	float = true,
	center = true,
	size = { 1000, 700 },
	workspace = "special",
})

hl.window_rule({
	name = "ktorrent-open-url-size",
	match = {
		class = "^(org.kde.ktorrent)$",
		title = "^(Open an URL - KTorrent)$",
	},
	size = { 800, 500 },
})

hl.window_rule({
	name = "opaque-windows",
	match = {
		class = "^(code-insiders-url-handler)$|^(code-insiders)$|^(vivaldi-stable)$|^(zen)$|^(com.gabm.satty)$|^(vlc)$|^(.*mpv.*)$",
	},
	opaque = true,
})

hl.window_rule({
	name = "subtle-opacity-terminals",
	match = { class = "^(kitty)$|^(io.missioncenter.MissionCenter)$|^(org.wezfurlong.wezterm)$" },
	opacity = "0.98 1",
})

hl.window_rule({
	name = "picture-in-picture",
	match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
	float = true,
	pin = true,
	keep_aspect_ratio = true,
	move = { "monitor_w*0.73", "monitor_h*0.72" },
	size = { "monitor_w*0.25", "monitor_h*0.25" },
})

hl.window_rule({
	name = "browsers-workspace-1",
	match = {
		class = "^(.*firefox.*)$|^(vivaldi-stable)$|^(.*opera.*)$|^(.*edge.*)$|^(.*Chromium.*)$|^(.*Google-chrome.*)$|^(.*thorium-browser.*)$|^(.*Brave-browser.*)$|^(.*zen.*)$",
	},
	workspace = "1",
})

hl.window_rule({
	name = "terminal-systemsettings-workspace-2",
	match = { class = ".*konsole.*|.*kitty.*|.*systemsettings.*|.*gnome-terminal.*" },
	workspace = "2",
})

hl.window_rule({
	name = "vscode-workspace-3",
	match = {
		class = "^(Code)$|^(code-oss)$|^(code-url-handler)$|^(code-insiders-url-handler)$|^(code-insiders)$|^(Code - Insiders)$",
	},
	workspace = "3",
})

hl.window_rule({
	name = "workspace-4-tools",
	match = {
		class = "^(.*studio.*)$|^(.*jetbrains-studio.*)$|^(.*DBeaver.*)$|^(Postman)$|^(obsidian)$|^(MongoDB Compass)$",
		title = "^(.*LibreOffice.*)$|^(.*pgadmin4.*)$",
	},
	workspace = "4",
})

hl.window_rule({
	name = "workspace-5-filemanagers",
	match = { class = "^(.*dolphin.*)$|^(.*pcmanfm-qt.*)$|^(.*nemo.*)$|^(.*ark.*)$|.*Nautilus.*" },
	workspace = "5",
})

hl.window_rule({
	name = "workspace-6-media",
	match = {
		class = "^(.*amarok.*)$|^(.*G4Music.*)$|.*music.*|.*lollypop.*|^(.*elisa.*)$|^(.*vlc.*)$|^(.*easyeffects.*)$|^(.*mpv.*)$|^(.*strawberry.*)$|^(com.github.rafostar.Clapper)$|^(Spotify)$|^(Audacity)$",
	},
	workspace = "6",
})

hl.window_rule({
	name = "workspace-7-communication",
	match = {
		class = "^(ferdium)$|^(Station)$|^(.*discord.*)$|^(.*thunderbird.*)$",
		title = "^(.*Telegram.*)$|^(.*Messages for web.*)$",
	},
	workspace = "7",
})

hl.window_rule({
	name = "workspace-8-gaming",
	match = {
		class = "^(.*org.libretro.RetroArch.*)$|^(.*pcsx2-qt.*)$|.*PCSX2.*|^(.*PPSSPPQt.*)$|^(.*steam.*)$",
		title = "^(.*Winetricks.*)$|^(Waydroid)$",
	},
	workspace = "8",
})

----------
-- Misc
----------

hl.config({
	misc = {
		swallow_regex = "(foot|kitty|alacritty|Alacritty|ghostty|Ghostty)",
	},
	ecosystem = {
		no_update_news = true,
	},
})

-----------------
-- Keybindings
-----------------

hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

---------------
-- Layer rules
---------------

hl.layer_rule({
	name = "tsumiki-notifications",
	match = { namespace = "tsumiki-notifications" },
	blur = true,
	xray = true,
	blur_popups = true,
	ignore_alpha = 0,
	no_anim = true,
})

hl.layer_rule({
	name = "fabric-layer",
	match = { namespace = "fabric" },
	blur = true,
	ignore_alpha = 0,
	xray = true,
	blur_popups = true,
})

hl.layer_rule({
	name = "tsumiki-layer",
	match = { namespace = "tsumiki" },
	blur = true,
	xray = true,
	blur_popups = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	name = "gtk-layer-shell",
	match = { namespace = "gtk-layer-shell" },
	blur = true,
	ignore_alpha = 0,
})

hl.layer_rule({
	name = "launcher-layer",
	match = { namespace = "launcher" },
	blur = true,
	xray = true,
	blur_popups = true,
	ignore_alpha = 0,
	animation = "popin",
})
