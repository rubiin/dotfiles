
todo: fix the widget style on widget settings

todo: mke the seekbar longer

todo: hyprland client

todo: use uv


todo: weather highlight color makes  label and icon color less readable


todo: fix keybind cheatsheet (https://github.com/noctalia-dev/legacy-v4-plugins/blob/main/keybind-cheatsheet/preview.png)

todo: add graph for upload download(https://github.com/noctalia-dev/legacy-v4-plugins/blob/main/network-indicator/preview.png)

todo: unicode picker (https://github.com/noctalia-dev/legacy-v4-plugins/blob/main/unicode-picker/preview.png)

todo: multiple sound source support:

https://github.com/noctalia-dev/noctalia-plugins/tree/main/show-keys

todo: https://github.com/noctalia-dev/legacy-v4-plugins/blob/main/github-feed/preview.png

todo: fix eventbox hover teal highlight

TODO: add popover animation

TODO: fix the sliders on quick settings, vertical layout is broken

todo: add brightness and volume tooltips

Traceback (most recent call last):
  File "/home/devina/.config/tsumiki/widgets/quick_settings/togglers.py", line 83, in on_click
    self.popup.hide_popover()
    ^^^^^^^^^^^^^^^^^^^^^^^
AttributeError: 'NoneType' object has no attribute 'hide_popover'
Traceback (most recent call last):
  File "/home/devina/.config/tsumiki/widgets/quick_settings/togglers.py", line 83, in on_click
    self.popup.hide_popover()
    ^^^^^^^^^^^^^^^^^^^^^^^
AttributeError: 'NoneType' object has no attribute 'hide_popover'
Traceback (most recent call last):
  File "/home/devina/.config/tsumiki/widgets/quick_settings/togglers.py", line 45, in <lambda>
    self.connect("clicked", lambda *_: popup.hide_popover())
                                       ^^^^^^^^^^^^^^^^^^
AttributeError: 'NoneType' object has no attribute 'hide_popover'

TODO: add weather in the panel

[Feature Request] Add keyboard indicator for NumLock, CapsLock & ScrollLock keys

https://lazka.github.io/pgi-docs/

mpris:https://raw.githubusercontent.com/AhmedSaadi0/NibrasShell/084752b2e960252edd4b07acf0410a99514572d3/screenshots/smart-c.gif


(To verify): add a delayed function call


WORKSPACE_LABELS = {
    0: ".",
    1: "一",
    2: "二",
    3: "三",
    4: "四",
    5: "五",
    6: "六",
    7: "七",
    8: "八",
    9: "九",
    10: "十",
}


bug: fix wifi ap client disconnect button


https://github.com/Jas-SinghFSU/HyprPanel/issues/770
https://github.com/Jas-SinghFSU/HyprPanel/issues/805
https://github.com/Jas-SinghFSU/HyprPanel/i1ssues/614


https://github.com/hyprland-community/awesome-hyprland


Throttle frequent signals: If you're connecting to things like "changed" or "motion-notify-event", debounce or rate-limit them.

https://github.com/ilyamiro/nixos-configuration

https://github.com/caelestia-dots/shell

https://github.com/dianaw353/Lunur-Shell/blob/main/utils/gen_keybinds.py

https://github.com/ezerinz/epik-shell

https://github.com/muhchaudhary/fabric-nix

https://github.com/amansxcalibur/zenith

https://github.com/S4NKALP/Modus/blob/new/modules/dock/components/applications.py

https://github.com/AhmedSaadi0/NibrasShell

https://github.com/AMNatty/wleave

https://github.com/xZepyx/HyprZepyx

https://github.com/Neurarian/matshell

https://github.com/tr1xem/flux


    def toggle_flight_mode(self, *_):
        try:
            self.flight_mode = not self.flight_mode

            if self.flight_mode:
                # Turn off WiFi and Bluetooth
                if self.wifi_service:
                    self.wifi_service.wireless_enabled = False
                if hasattr(self, "bluetooth_man") and hasattr(
                    self.bluetooth_man, "client"
                ):
                    self.bluetooth_man.client.set_enabled(False)
            else:
                # Turn on WiFi and Bluetooth
                if self.wifi_service:
                    self.wifi_service.wireless_enabled = True
                if hasattr(self, "bluetooth_man") and hasattr(
                    self.bluetooth_man, "client"
                ):
                    self.bluetooth_man.client.set_enabled(True)

            # Update icon
            self.flight_icon.set_from_file(
                get_relative_path(
                    "../../config/assets/icons/applets/flight-on.svg"
                    if self.flight_mode
                    else "../../config/assets/icons/applets/flight-off.svg"
                )
            )



INSPIRATIONS:
https://github.com/MalpenZibo/ashell






# QoL Feature Suggestions

## 🟢 Low Effort / Config-Change Only

### 1. Config Validation with User-Friendly Errors
When the TOML config has a typo or schema violation, show a notification with the exact line and issue instead of crashing silently. Already have `validate_config_enums` and `validate_widgets` — just plumb errors to `send_notification`.



### 3. Per-Widget Auto-Hide
Bar has global auto-hide. Add `hide_on_idle: true` per-widget so non-essential widgets (system tray, weather, git companion) hide after inactivity while core ones (workspaces, clock) stay visible.

### 4. Quick Settings Presets (e.g. "Presentation Mode")
Save/restore groups of toggles: DND on, max brightness, volume mute, idle inhibition. One-click button in quick settings panel.

## 🟡 Medium Effort

### 5. Blue Light Filter Scheduler (Hyprsunset at Sunrise/Sunset)
Auto-enable hyprsunset at sunset / disable at sunrise using geo-IP or weather service.

### 6. Do Not Disturb Scheduler
Time-based DND rules: start/end time, allow-critical toggle.

### 7. System Resource History Sparklines
Inline sparkline graphs for CPU/memory/storage showing last N readings.

### 8. Bluetooth Auto-Connect Profiles
Auto-connect specific devices when in range. Profile-based configuration.

### 9. Audio Output/Input Device Quick Switcher
Device selector popup showing available sinks/sources with one-click switching.

### 10. Notification Grouping by App
Group notifications from the same app with expand/collapse and count badge.

## 🔴 Higher Effort / New Features

### 11. Focus Mode
Temporarily hides distracting widgets for a configurable duration with timer overlay.

### 12. Workspace-Aware Theming
Different wallpaper or color scheme per workspace.

### 13. Backup & Restore Config
Export/import current config (TOML + theme) as a single archive file from Settings GUI.

### 14. Gesture Customization (Touchpad/Touchscreen)
Configurable gesture bindings (three-finger swipe, four-finger tap, etc.)

### 15. Session Autostart Manager
UI within settings to manage autostart applications.

### 16. Dynamic Keyboard Shortcut Cheatsheet
Show current Hyprland keybinds parsed from config, or app-specific shortcuts when a window is focused.

### 17. Battery Charge Limiter Integration
Toggle charge limit to 60-80% for Lenovo/ASUS/Dell laptops.

### 18. Quick Timer (Separate from Pomodoro)
Simple countdown timer with presets (1/5/10/15 mins) that fires a notification when done.

### 19. Network Performance Graph
Rolling throughput graph (last 60s) in network usage tooltip.

### 20. Per-Monitor Widget Placement
Specify which widgets go on which monitor.

## 🛠️ Settings GUI Improvements

- Lists/arrays not editable — layout strings, ignored apps, timezone lists show as plain text
- No search — with 40+ widgets, finding a setting is scrolling-heavy
- No reset-to-default per field — only a full-reset button
- No visual preview — theme changes require save + reload to see
- No import/export — share configs



Implement notification click-to-activate-app (left-click = focus source app, drag = dismiss)


Add clear-all button to notification popup

Update config.toml example with new options

Validate syntax and run code review
