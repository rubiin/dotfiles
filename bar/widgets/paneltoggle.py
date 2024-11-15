from fabric.widgets.button import Button
from fabric.utils import exec_shell_command,exec_shell_command_async,invoke_repeater

class CommandSwitcher(Button):
    @staticmethod
    def cat_icon(text: str, icon: str | None = None):
        return f"{(' ' + icon) if icon else ''}{text}"

    def __init__(self, command: str, icon: str | None = None, **kwargs):
        super().__init__(label=self.cat_icon("ON", icon),name="panel-button")

        self.icon = icon
        self.command = command
        self.command_without_args = self.command.split(" ")[0] # command without args

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
        self.set_label(self.cat_icon("ON" if self.is_active() else "OFF", self.icon))
        return True