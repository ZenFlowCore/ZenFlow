from fabric.widgets.label import Label
from fabric.widgets.box import Box
from fabric.widgets.eventbox import EventBox

from fabric.core.fabricator import Fabricator
from fabric.audio import Audio  # For pulseaudio equivalent
from utils.icons import *
import time
import psutil

class SystemWidgets:
    def __init__(self):
        # CPU widget
        self.cpu = Label(label=cpu + " 0%", style_classes=["cpu-widget"])

        # Memory widget
        self.memory = Label(label=memory +" 0%", style_classes=["memory-widget"])

        # Disk widget
        self.disk = Label(label=disk + " 0%", style_classes=["disk-widget"])

        # Network widget
        self.network = Label(label=download, style_classes=["network-widget"])

        # Battery widget (you already have this)
        self.battery = Label(label=battery + " 0%", style_classes=["battery-widget"])

class CPUWidget(Label):
    def __init__(self):
        super().__init__(label="󰘚 0%")

        # Create a fabricator to poll CPU usage
        self.cpu_fabricator = Fabricator(
            poll_from=self.get_cpu_usage,
            interval=1000,  # Update every second
        )
        self.cpu_fabricator.connect("changed", self.update_label)

    def get_cpu_usage(self, fabricator):
        return psutil.cpu_percent()

    def update_label(self, fabricator, value):
        self.label = f"󰘚 {value:.0f}%"

class MemoryWidget(Label):
    def __init__(self):
        super().__init__(label=" 0%")

        self.memory_fabricator = Fabricator(
            poll_from=self.get_memory_usage,
            interval=2000,  # Update every 2 seconds
        )
        self.memory_fabricator.connect("changed", self.update_label)

    def get_memory_usage(self, fabricator):
        return psutil.virtual_memory().percent

    def update_label(self, fabricator, value):
        self.label = f" {value:.0f}%"

class DiskWidget(Label):
    def __init__(self):
        super().__init__(label="0%")

        self.disk_fabricator = Fabricator(
            poll_from=self.get_disk_usage,
            interval=5000,
        )
        self.disk_fabricator.connect("changed", self.update_label)

        def get_disk_usage(self, fabricator):
            return psutil.disk_usage('/').percent

        def update_label(self, fabricator, value):
            self.label = f" {value:.0f}%"

class NetworkWidget(Label):
    def __init__(self):
        super().__init__(label="")

        self.network_fabricator = Fabricator(
            poll_from=self.network_speed,
            interval=500
        )
        self.network_fabricator.connect("changed", self.update_label)

        def get_network_speed(self, fabricator):
            return psutil.net_if_stats()

        def update_label(self, fabricator, value):
            self.label = f" {value:.0f}%"
