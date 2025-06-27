from fabric.audio import Audio
from fabric.widgets.label import Label
from fabric.widgets.eventbox import EventBox

from utils.icons import *

class AudioWidget(EventBox):
    def __init__(self):
        super().__init__(events=["button-press", "scroll"])
        self.audio = Audio()
        self.label = Label()
        self.children = self.label

        # Connect to audio changes
        self.audio.speaker.connect("changed", self.update_display)
        self.connect("scroll-event", self.on_scroll)

    def update_display(self, *args):
        speaker = self.audio.speaker
        if speaker.muted:
            icon = vol_mute
        else:
            volume = int(speaker.volume)
            if volume > 66:
                icon = vol_high
            elif volume > 0:
                icon = vol_medium
            elif volume == 0:
                icon = vol_mute
            else:
                icon = "󰕿"

        self.label.label = f"{int(speaker.volume)}% {icon}"

    def on_scroll(self, widget, event):
        # Volume control on scroll
        speaker = self.audio.speaker
        if event.direction == Gdk.ScrollDirection.UP:
            speaker.volume = min(100, speaker.volume + 5)
        elif event.direction == Gdk.ScrollDirection.DOWN:
            speaker.volume = max(0, speaker.volume - 5)
