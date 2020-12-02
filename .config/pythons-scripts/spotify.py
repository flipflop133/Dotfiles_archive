# imports
import os
import subprocess
import time
import json
try:
    import dbus
except ModuleNotFoundError:
    n = os.fork()
    if n == 0:
        subprocess.run(["pip", "install", "dbus-python"])
        import dbus
    else:
        os.wait()


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
    """Retrieve Spotify current playing song using dbus
    """
    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object('org.mpris.MediaPlayer2.spotify',
                                         '/org/mpris/MediaPlayer2')

    spotify_properties = dbus.Interface(spotify_bus,
                                        'org.freedesktop.DBus.Properties')
    metadata = spotify_properties.Get('org.mpris.MediaPlayer2.Player',
                                      'Metadata')
    artist = metadata['xesam:artist'][0] if metadata['xesam:artist'] else ''
    song = metadata['xesam:title'] if metadata['xesam:title'] else ''

    # check for ads
    global ad
    ad = blockAds(song, ad)

    # determine icon
    status = get_playBackStatus()
    if status == "Paused":
        icon = ''
    else:
        icon = ''

    # display song name
    if song != '' and 'Advertisement' not in song and artist != '' and isSong is False:
        isSong = True
        print("{} {}".format(icon, song))

    # display artist name
    elif song != '' and 'Advertisement' not in song and artist != '' and isSong is True:
        isSong = False
        print("{} {}".format(icon, artist))
    return isSong, ad


def get_playBackStatus():
    """Use Dbus to find the current playback status
    """
    player = Dbus.obj_player + "." + "spotify"
    player = dbus.SessionBus().get_object(player, Dbus.path_player)
    properties = dbus.Interface(player, Dbus.intf_props)
    return properties.Get(Dbus.intf_player, "PlaybackStatus")


try:
    data = None
    try:
        with open("/tmp/spotify.json", "r") as read_file:
            data = json.load(read_file)
    except IOError:
        dict = {"ad": False, "isSong": False}
        with open("/tmp/spotify.json", "w+") as read_file:
            json.dump(dict, read_file)
    if data is not None:
        ad = bool(data['ad'])
        isSong = bool(data['isSong'])
        values = getSong(isSong)
        if values == "no_process":
            print("")
        else:
            isSong = values[0]
            ad = values[1]
            dict = {"ad": ad, "isSong": isSong}
            with open("/tmp/spotify.json", "w") as read_file:
                json.dump(dict, read_file)

except Exception as e:
    if isinstance(e, dbus.exceptions.DBusException):
        print('')
    else:
        print(e)
