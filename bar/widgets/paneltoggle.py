from fabric.widgets.button import Button
from fabric.utils import exec_shell_command,exec_shell_command_async,invoke_repeater

class CommandSwitcher(Button):
    @staticmethod
    def cat_icon(text: str, icon: str): 
        return f"{icon} {text}"

    def __init__(self, command: str, enabled_icon: str , disabled_icon: str, enable_label: bool | None = None ,enable_tooltip: bool | None = None):
        self.command = command
        self.command_without_args = self.command.split(" ")[0] # command without args

        super().__init__(label=self.cat_icon("On", ""),name="panel-button")

        self.enabled_icon = enabled_icon
        self.disabled_icon = disabled_icon
        self.enable_label = enable_label
        self.enable_tooltip = enable_tooltip


        self.connect("clicked", self.toggle)
        invoke_repeater(2000, self.update)

    def is_active(self, *_):
        return (
            exec_shell_command(
                f"bash -c 'pgrep -x {self.command_without_args} > /dev/null && echo yes || echo no'"
            ).strip()
            == "yes"
        )

    def toggle(self, *_):
        if self.is_active():
            exec_shell_command(f"pkill {self.command_without_args}")
        else:
            exec_shell_command_async(f"bash -c '{self.command}&'", lambda *_: None)
        return self.update()

    def update(self, *_):
        if self.enable_label and self.enable_label is not None:
         self.set_label(self.cat_icon("On" if self.is_active() else "Off", self.enabled_icon if self.is_active() else self.disabled_icon)) 
        if self.enable_tooltip and self.enable_tooltip is not None:
            self.set_tooltip_text(f"{self.command_without_args} enabled" if self.is_active() else f"{self.command_without_args} disabled" )
        return True