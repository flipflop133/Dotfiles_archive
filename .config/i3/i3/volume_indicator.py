# volume indicator script using linux_notification_center
# https://github.com/phuhl/linux_notification_center

import os
f = os.popen("amixer sget Master")
now = f.read()
now = now.split()
for i in range(len(now)):
    if 'Left:' in now[i] and 'Playback' in now[i + 1]:
        volume = now[i + 3]
        mute = now[i + 4]

volume = volume.strip('[')
volume = int(volume.strip('%]'))
mute = mute.strip('[')
mute = mute.strip(']')

if volume > 20:
    ICON = 'audio-volume-medium'
elif volume > 40:
    ICON = 'audio-volume-high'
else:
    ICON = 'audio-volume-low'
if mute == 'off':
    ICON = 'audio-volume-muted'
os.popen(
    "notify-send.py \"Volume\" \"%s/100\" --hint string:image-path:%s boolean:transient:true --replaces-process \"volume-popup\""
    % (volume, ICON))
