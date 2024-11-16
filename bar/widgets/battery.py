import psutil

from fabric.utils import invoke_repeater
from fabric.widgets.box import Box
from fabric.widgets.label import Label

from utils import NerdIcon, format_time


class BatteryLabel(Box):
    
    ICONS_CHARGING = [
        "󰂆", #10
        "󰂆",
        "󰂇",
        "󰂇",
        "󰂈",
        "󰢝",
        "󰂉",
        "󰢞",
        "󰂊",
        "󰂋",
        "󰂅",
    ]
    ICONS_NOT_CHARGING = [
        "󰂃",#0
        "󰁺",#10
        "󰁻",
        "󰁼",
        "󰁽",
        "󰁾",
        "󰁿",
        "󰂀",
        "󰂁",
        "󰂂",
        "󰁹",
    ]

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        invoke_repeater(2000, self.update_battery_status, initial_call=True)

    def update_battery_status(self):
        battery = psutil.sensors_battery()

        
        print(battery.percent)
        if battery is None:
          
            self.hide()
            return

        battery_percent = round(battery.percent) if battery else 0.0

        print(battery_percent)

        battery_label = Label(label=f"{battery_percent}%")

        is_charging = battery.power_plugged if battery else False
        icons = self.ICONS_CHARGING if is_charging else self.ICONS_NOT_CHARGING

        index = min(max(battery_percent // 10, 0), 10)
        battery_icon =  NerdIcon(icons[index], size="16px")

        self.children = (battery_icon,battery_label)

        ## fix this to display time left for charging 
        if not  is_charging:
          self.set_tooltip_text(format_time(battery.secsleft))


        return True
