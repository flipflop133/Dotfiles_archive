# imports
import os
import subprocess
import time
import json
import dbus

command = "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata".split(
)

# store if the previous song was an ad
try:
    with open("/tmp/spotify.json", "r") as read_file:
        data = json.load(read_file)
except IOError:
    dict = {"ad": False, "isSong": False}
    with open("/tmp/spotify.json", "w") as read_file:
        json.dump(dict, read_file)
ad = bool(data['ad'])
isSong = bool(data['isSong'])


class Dbus:
    obj_dbus = "org.freedesktop.DBus"
    path_dbus = "/org/freedesktop/DBus"
    obj_player = "org.mpris.MediaPlayer2"
    path_player = "/org/mpris/MediaPlayer2"
    intf_props = obj_dbus + ".Properties"
    intf_player = obj_player + ".Player"


def blockAds(song, ad):
    """Mute sound during ads
        """
    # get mute status
    f = os.popen("pacmd list-sinks | awk '/muted/ { print $2 }'")
    mute = f.read()
    # mute sound if spotify is playing and AD
    if 'Advertisement' in song and 'yes' not in mute:
        subprocess.call(['pactl', 'set-sink-mute', '0', "toggle"])
        ad = True
        time.sleep(5)
    if 'Advertisement' not in song and 'yes' in mute and ad:
        subprocess.call(['pactl', 'set-sink-mute', '0', "toggle"])
    if 'Advertisement' not in song:
        ad = False
    return ad


def getSong(isSong):
    try:
        # retrieve song data
        result = subprocess.run(command, capture_output=True, text=True)
        result = result.stdout
        result = result.strip()
        result = result.split("dict entry")

        # Song
        song = result[9]
        song = song.replace("(", "").replace(")", "").replace("\"", "").split()
        finalSong = ""
        for i in range(4, len(song)):
            finalSong += song[i] + " "
        # check for ads
        global ad
        ad = blockAds(finalSong, ad)

        # artist
        song = result[6]
        song = song.replace("\"", "").replace("]", "").replace(")", "").split()
        artistName = ""
        for i in range(7, len(song)):
            artistName += song[i] + " "
        # determine icon
        status = get_playBackStatus()
        if status == "Paused":
            icon = ''
        else:
            icon = ''
        # display song name
        if finalSong != '' and 'Advertisement' not in finalSong and artistName != '' and isSong is False:
            isSong = True
            print("{} {}".format(icon, finalSong))

        # display artist name
        elif finalSong != '' and 'Advertisement' not in finalSong and artistName != '' and isSong is True:
            isSong = False
            print("{} {}".format(icon, artistName))
        return isSong, ad

    except subprocess:
        return "no_process"


def get_playBackStatus():
    """Use Dbus to find the current playback status
        """
    player = Dbus.obj_player + "." + "spotify"
    player = dbus.SessionBus().get_object(player, Dbus.path_player)
    properties = dbus.Interface(player, Dbus.intf_props)
    return properties.Get(Dbus.intf_player, "PlaybackStatus")


values = getSong(isSong)
if values == "no_process":
    print("")
else:
    isSong = values[0]
    ad = values[1]
    dict = {"ad": ad, "isSong": isSong}
    with open("/tmp/spotify.json", "w") as read_file:
        json.dump(dict, read_file)
