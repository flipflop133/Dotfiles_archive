# imports
from i3pystatus import IntervalModule
import subprocess
import os
import time


class custom_spotify(IntervalModule):

    color = '#ffffff'
    settings = ("format", "color")

    # store if the previous song was an ad
    ad = False

    isSong = False

    def blockAds(song):
        # get mute status
        f = os.popen("pacmd list-sinks | awk '/muted/ { print $2 }'")
        mute = f.read()
        # mute sound if spotify is playing and AD
        if 'Advertisement' in song and 'yes' not in mute:
            subprocess.call(['pactl', 'set-sink-mute', '0', "toggle"])
            custom_spotify.ad = True
            time.sleep(5)
        if 'Advertisement' not in song and 'yes' in mute and custom_spotify.ad == True:
            subprocess.call(['pactl', 'set-sink-mute', '0', "toggle"])
        if 'Advertisement' not in song:
            custom_spotify.ad = False

    def getSong(self):
        # song name
        f = os.popen(
            "dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata | sed -n '/title/{n;p}' | cut -d '\"' -f 2"
        )
        song = (f.read()).split()
        finalSong = ''
        for i in song:
            finalSong += i + ' '
        # check for ads
        custom_spotify.blockAds(finalSong)
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

        if finalSong != '' and 'Advertisement' not in finalSong and artistName != '' and custom_spotify.isSong is False:
            custom_spotify.isSong = True
            cdict = {'song': finalSong, 'artist': ''}
            return cdict
        if finalSong != '' and 'Advertisement' not in finalSong and artistName != '' and custom_spotify.isSong is True:
            custom_spotify.isSong = False
            cdict = {'song': '', 'artist': artistName}
            return cdict

    def run(self):
        try:
            cdict = self.getSong()
            self.data = cdict
            self.output = {
                "full_text": self.format.format(**cdict),
                "color": self.color,
            }
        except:
            self.output = {
                "full_text": '',
            }
