# imports
import os
import subprocess
import time
import json
import dbus
# store if the previous song was an ad
with open("/home/francois/.config/pythons-scripts/spotify.json",
          "r") as read_file:
    data = json.load(read_file)
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
    # song name
    f = os.popen(
        "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}'"# | cut -d '\"' -f 2"
    )
    song = (f.read()).split()
    finalSong = ''
    for i in range(2,len(song)):
        finalSong += song[i] + ' '
    finalSong = finalSong.replace("\"",'')
    # check for ads
    global ad
    ad = blockAds(finalSong, ad)
    # artist
    f = os.popen(
        "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata"
    )
    artist = (f.read()).split()
    artistName = ''
    for i in range(len(artist)):
        if artist[i] == "\"xesam:artist\"":
            artistName = artist[i + 5] + ' ' + artist[i + 6]
            # filter weird characters
            artistName = artistName.strip(']')
            artistName = artistName.replace('"', '')
            artistName = 'by ' + artistName

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


def get_playBackStatus():
    """Use Dbus to find the current playback status
        """
    player = Dbus.obj_player + "." + "spotify"
    player = dbus.SessionBus().get_object(player, Dbus.path_player)
    properties = dbus.Interface(player, Dbus.intf_props)
    return properties.Get(Dbus.intf_player, "PlaybackStatus")


def set_pause():
    """Toggle play/pause using dbus
        """
    os.popen(
        "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
    )
    icon = "play"


def play_next():
    """Play the next song using dbus
        """
    os.popen(
        "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"
    )


values = getSong(isSong)
isSong = values[0]
ad = values[1]
dict = {"ad": ad, "isSong": isSong}
with open("/home/francois/.config/pythons-scripts/spotify.json",
          "w") as read_file:
    json.dump(dict, read_file)
