# volume indicator script using linux_notification_center
# https://github.com/phuhl/linux_notification_center
# requires notify-send.py:
# pip install notify-send.py

import os
status = os.popen("pulseaudio-ctl full-status")
status = (status.read()).split()

volume = int(status[0])

if volume > 20:
    ICON = 'audio-volume-medium'
elif volume > 40:
    ICON = 'audio-volume-high'
else:
    ICON = 'audio-volume-low'
if status[1] == 'yes':
    ICON = 'audio-volume-muted'
os.popen(
    "notify-send.py \"Volume\" \"%s/100\" --hint string:image-path:%s boolean:transient:true --replaces-process \"volume-popup\""
    % (volume, ICON))
