from i3pystatus import IntervalModule
import os


class notification_center(IntervalModule):

    on_leftclick = "open_notifications"
    color = "#ffffff"
    settings = ("format", ("interval", "update interval"), "color")
    interval = 1

    def open_notifications(self):
        os.popen("kill -s USR1 $(pidof deadd-notification-center)")

    def run(self):
        self.output = {
            "full_text": self.format.format(''),
            "color": self.color
        }
