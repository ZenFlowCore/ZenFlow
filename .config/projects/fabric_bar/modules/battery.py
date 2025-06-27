from fabric.core.fabricator import Fabricator
from fabric.widgets.button import Button
from fabric.widgets.box import Box
from gi.repository import GLib
from fabric.widgets.label import Label
from fabric.widgets.circularprogressbar import CircularProgressBar
from fabric.widgets.revealer import Revealer
import utils.icons as icons
import utils.data as data
import psutil
import time

class Metrics:

    def __init__(self):

        self.bat_percent = 0.0
        self.bat_charging = None

        GLib.timeout_add_seconds(1, self._update)


    def get_battery(self):
        return (self.bat_percent, self.bat_charging)

    def _update(self):

        battery = psutil.sensors_battery()
        if battery is None:
            self.bat_percent = 0.0
            self.bat_charging = None
        else:
            self.bat_percent = battery.percent
            self.bat_charging = battery.power_plugged

        return True

shared_provider = Metrics()


class Battery(Button):
    def __init__(self, **kwargs):
        super().__init__(name="metrics-small", **kwargs)

        # Create the main box for metrics widgets
        main_box = Box(
            # name="metrics-small",
            spacing=0,
            orientation="h",
            visible=True,
            all_visible=True,
        )

        # ------------------ Battery ------------------
        self.bat_icon = Label(name="metrics-icon", markup=icons.battery)


        #self.bat_circle = CircularProgressBar(
        #    name="metrics-circle",
        #    value=0,
        #    size=28,
        #    line_width=2,
        #    start_angle=150,
        #    end_angle=390,
        #    style_classes="bat",
        #    child=self.bat_icon,
        #)

        self.bat_level = Label(name="metrics-level", label="100%")
        self.bat_revealer = Revealer(
            name="metrics-bat-revealer",
            transition_duration=250,
            transition_type="slide-left",
            child=self.bat_level,
            child_revealed=False,
        )
        self.bat_box = Box(
            name="metrics-bat-box",
            orientation="h",
            spacing=3,
            children=[self.bat_icon, self.bat_revealer]
        )

        # Add the battery widget to the main container
        main_box.add(self.bat_box)

        # Set the main box as the button's child
        self.add(main_box)

        # Connect events directly to the button
        self.connect("enter-notify-event", self.on_mouse_enter)
        self.connect("leave-notify-event", self.on_mouse_leave)

        # Actualización de la batería cada segundo
        self.batt_fabricator = Fabricator(
            poll_from=lambda v: shared_provider.get_battery(),
            on_changed=lambda f, v: self.update_battery,
            interval=1000,
            stream=False,
            default_value=0
        )
        self.batt_fabricator.changed.connect(self.update_battery)
        GLib.idle_add(self.update_battery, None, shared_provider.get_battery())

        # Estado inicial de los revealers y variables para la gestión del hover
        self.hide_timer = None
        self.hover_counter = 0

    def _format_percentage(self, value: int) -> str:
        """Formato natural del porcentaje sin forzar ancho fijo."""
        return f"{value}%"

    def on_mouse_enter(self, widget, event):
        if not data.VERTICAL:
            self.hover_counter += 1
            if self.hide_timer is not None:
                GLib.source_remove(self.hide_timer)
                self.hide_timer = None
            # Revelar niveles en hover para todas las métricas
            self.bat_revealer.set_reveal_child(True)
            return False

    def on_mouse_leave(self, widget, event):
        if not data.VERTICAL:
            if self.hover_counter > 0:
                self.hover_counter -= 1
            if self.hover_counter == 0:
                if self.hide_timer is not None:
                    GLib.source_remove(self.hide_timer)
                self.hide_timer = GLib.timeout_add(500, self.hide_revealer)
            return False

    def hide_revealer(self):
        if not data.VERTICAL:
            self.bat_revealer.set_reveal_child(False)
            self.hide_timer = None
            return False

    def update_battery(self, sender, battery_data):
        value, charging = battery_data
        if value == 0:
            self.set_visible(False)
        else:
            self.set_visible(True)
            #self.bat_circle.set_value(value / 100)
        percentage = int(value)
        self.bat_level.set_label(self._format_percentage(percentage))

        # Apply alert styling if battery is low, regardless of charging status
        if percentage == 100:
            self.bat_icon.add_style_class("full")
            self.bat_level.add_style_class("full")
        elif charging == True:
            self.bat_icon.add_style_class("charging")
            self.bat_level.add_style_class("charging")
        elif percentage <= 15:
            self.bat_icon.add_style_class("alert")
            self.bat_level.add_style_class("alert")
            #self.bat_circle.add_style_class("alert")
        elif charging == False:
            self.bat_icon.add_style_class("discharging")
            self.bat_level.add_style_class("discharging")
        else:
            self.bat_icon.remove_style_class("alert")
            #self.bat_circle.remove_style_class("alert")

        # Choose the icon based on charging state first, then battery level
        if percentage == 100:
            self.bat_icon.set_markup(icons.bat_discharging_high)
            charging_status = f"{icons.bat_discharging_high} Fully Charged"
        elif charging == True and percentage == 100:
            self.bat_icon.set_markup(icons.bat_charging_full)
            charging_status = f"{icons.bat_charging_full} Fully Charged"
        elif charging == True:
            self.bat_icon.set_markup(icons.bat_charging)
            charging_status = f"{icons.bat_charging} Charging"
        elif charging == False and percentage >= 75:
            self.bat_icon.set_markup(icons.bat_discharging_medium_high)
            charging_status = f"{icons.bat_discharging_medium_high} Charging"
        elif charging == False and percentage >= 50:
            self.bat_icon.set_markup(icons.bat_discharging_medium)
            charging_status = f"{icons.bat_discharging_medium} Charging"
        elif percentage < 50 and charging == False:
            self.bat_icon.set_markup(icons.bat_discharging_low)
            charging_status = f"{icons.bat_discharging_low} Low Battery"
        else:
            self.bat_icon.set_markup(icons.battery)
            charging_status = "Battery"

        # Set a descriptive tooltip with battery percentage
        self.set_tooltip_markup(f"{charging_status}" if not data.VERTICAL else f"{charging_status}: {percentage}%")
