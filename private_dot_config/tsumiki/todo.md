
todo: fix the widget style on widget settings

todo: validate enums for settings

TODO: make it dynamic based on the number of bar

todo: add brightness and volume tooltips

https://github.com/noctalia-dev/noctalia-plugins/tree/main/show-keys


feat: bubble styled workspace

TODO: add weather in the panel

feat: replace notification when it has replace_id
[Feature Request] Toggle Darkmode

[Feature Request] Add keyboard indicator for NumLock, CapsLock & ScrollLock keys

https://lazka.github.io/pgi-docs/

mpris:https://github.com/AhmedSaadi0/nibrasshell/blob/quickshell/screenshots/smart-c.gif


todo: Option to reveal bar on mouse hover


(To verify): add a delayed function call
(To verify): keybinds on powermenu



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

TODO: add popover animation



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



launcher position, view mode(grid)
