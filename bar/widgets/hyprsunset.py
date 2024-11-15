from fabric.widgets.button import Button
from fabric.widgets.label import Label
from fabric.widgets.box import Box
from fabric.utils import exec_shell_command

from utils import invoke_repeater_threaded



class HyprSunset(Button):
    def __init__(self, **kwargs):
        super().__init__(name="panel-button", **kwargs)
        self.hyprsunset_button_label = Label(label="On", name="panel-button-text")
        self.hyprsunset_button_icon = Label(label="", name="panel-button-icon")
        self.add(Box(children=[self.hyprsunset_button_icon,self.hyprsunset_button_label]))
        self.connect("clicked",self.on_click)
        self.update_labels()

        invoke_repeater_threaded(1500, lambda *args: self.update_labels())


    def on_click(self, button, *args):
        self.toggle()

    def is_active(self):
        status_command = 'bash -c "pgrep -x \"hyprsunset\" > /dev/null && echo \"yes\" || echo \"no\""' 

        status_response = exec_shell_command(
          status_command
        ).strip("\n")

        if status_response == "yes":
            return True
        else:
            return False 


        
    def update_labels(self):
        is_active = "On" if self.is_active() else "Off"
        self.hyprsunset_button_label.set_label(is_active)
        return True
    

    def toggle(self):
        temperature_value = "2800k"
        activate_command = f"nohup hyprsunset -t {temperature_value} > /dev/null 2>&1 &"
        kill_command = "pkill hyprsunset"
        if self.is_active():
            if exec_shell_command(kill_command):
                self.hyprsunset_button_label.set_label("Off")

        else:
            if exec_shell_command(activate_command):
                print("toggled")
                self.hyprsunset_button_label.set_label("On")
