from os import name
from fabric import Application
from fabric.utils.helpers import get_relative_path
from fabric.utils.helpers import monitor_file
from fabric.widgets.box import Box
from fabric.widgets.label import Label # gets the Label class
from fabric.widgets.window import Window # grabs the Window class from Fabri

if __name__ == "__main__":
    box_1 = Box(
        name="box",
        children=Label(label="Battery is running out!")
    )

    window = Window(child=box_1)

    app = Application("battery-checker", window)

    def apply_stylesheet(*_):
        return app.set_stylesheet_from_file(
            get_relative_path("style.css")
        )

    style_monitor = monitor_file(get_relative_path("./styles"))
    style_monitor.connect("changed", apply_stylesheet)
    apply_stylesheet() # initial styling
    app.run()
