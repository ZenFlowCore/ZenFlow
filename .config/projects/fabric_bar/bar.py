import fabric
from fabric import Application
from fabric.widgets.datetime import DateTime
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.wayland import WaylandWindow as Window
from fabric.utils.helpers import get_relative_path, monitor_file

from modules.arch import *
from modules.core import *
from modules.audio import *
from modules.workspaces import *
from modules.battery import Battery

import utils.icons as icons


class StatusBar(Window):
    def __init__(self, **kwargs):
        super().__init__(

            name="outer-bar",
            title="outer-bar",  # Explicitly set title to match layer rule
            layer="top",
            anchor="bottom left right",
            margin="0px 500px 10px 500px",
            exclusivity="auto",
            visible=True,
            all_visible=True,
        )

        self.set_app_paintable(True)
        screen = self.get_screen()
        visual = screen.get_rgba_visual()
        if visual:
            self.set_visual(visual)

        self.workspaces = Workspaces(
            name="workspaces",
            title="workspaces",
            spacing=10,
            style_classes=["workspace-container"],
            tooltip_text="Click to switch workspace, scroll to navigate",
            buttons_factory=lambda id: WorkspaceButton(
            id=id,
            label=str(id) if id != 10 else "0",
            style_classes=["workspace-button"],
            tooltip_text=f"Workspace {id}",
            style="font-family: JetBrainsMono Nerd Font Mono "
            )
        )


        # Create the main container
        self.main = CenterBox(name="inner-bar", h_expand=False)

        self.battery = Battery(
        style="""
        padding-right:20px;
        font-family: JetBrainsMono Nerd Font Mono;
        """,
        )

        self.arch = Label(
            name="arch_icon",
            markup=leaf,
            style="""padding-left: 10px; font-weight: bold; font-size: 20px;""",
            tooltip_text="Watchu lookin for?"
        )

        # Create widgets
        self.date_time = DateTime(
            name="datetime",
            style="""
            padding-right: 20px;
            font-family: JetBrainsMono Nerd Font Mono;
            """,
            h_expand=False,
            tooltip_text="Current date and time"
        )

        self.main.start_children = self.arch
        self.main.end_children = [self.date_time, self.battery]
        self.main.center_children = self.workspaces

        self.add(self.main)

        # Force minimum height at GTK level
        self.set_size_request(-1, 40)

        self.show_all()



if __name__ == "__main__":
    bar = StatusBar()
    app = Application("bar", bar)

    def apply_stylesheet(*_):
        try:
            app.set_stylesheet_from_file(get_relative_path("bar_style.css"))

        except FileNotFoundError:
            print("style.css not found, continuing without styling")

    try:
        style_monitor = monitor_file(get_relative_path("bar_style.css"))
        style_monitor.connect("changed", apply_stylesheet)
        apply_stylesheet()
    except FileNotFoundError:
        print("style.css not found, continuing without file monitoring")

    app.run()
