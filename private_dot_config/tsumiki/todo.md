
todo: fix the widget style on widget settings

feat: drag on dock

feat: bubble styled workspace

feat: group multiple instances of same app on dock

todo: vertical dock support

feat: custom mdoules

todo: cache pixbuf images for notifications

todo: add a delayed function call

https://github.com/Jas-SinghFSU/HyprPanel/issues/1038
https://github.com/Jas-SinghFSU/HyprPanel/issues/859
https://github.com/Jas-SinghFSU/HyprPanel/issues/770
https://github.com/Jas-SinghFSU/HyprPanel/issues/833
https://github.com/Jas-SinghFSU/HyprPanel/issues/805
https://github.com/Jas-SinghFSU/HyprPanel/issues/614
https://github.com/Jas-SinghFSU/HyprPanel/issues/515




https://github.com/hyprland-community/awesome-hyprland


Throttle frequent signals: If you're connecting to things like "changed" or "motion-notify-event", debounce or rate-limit them.

foor epik-shell
  box-shadow:
    0 0 0 $bar-border-width $bar-border-color,
    $bar-shadow-offset $bar-shadow-blur $bar-shadow-spread
      color.adjust($bar-shadow-color, $alpha: calc($bar-shadow-opacity - 1));


   f"vipsthumbnail '{image_path}' --size {size_arg} --output '{thumbnail_path}'"

https://github.com/caelestia-dots/shell/issues/555

https://github.com/dianaw353/Lunur-Shell/blob/main/utils/gen_keybinds.py
https://github.com/ezerinz/epik-shell

https://github.com/muhchaudhary/fabric-nix

https://github.com/amansxcalibur/zenith


https://github.com/S4NKALP/Modus/blob/new/modules/dock/components/applications.py

https://github.com/AhmedSaadi0/NibrasShell

https://github.com/AMNatty/wleave

https://github.com/xZepyx/HyprZepyx

TODO: keybinds on powermenu

TODO: invalidate weather cache on location change


bug: slider scale color for amplified and muted volume same as osd


bug: fix wwifi ap client disconnect button


TODO: expand notifications if content way too long


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

