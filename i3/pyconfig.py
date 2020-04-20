from i3pystatus import Status
status = Status()

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM
status.register("clock",
    format="🗓️ %a %-d %b %X",
	color="#df78ef",)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load")

# Shows avg cpu freq
status.register("cpufreq",format="⚡avg cpu freq: {freq} MHz",interval=1)

# Shows avg cpu temp
status.register("cputemp",format="🌡️avg cpu temp: {temp}°C",interval=1)

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register("network",
    interface="enp3s0",
    format_up="🌐{v4cidr}",)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
    path="/",
    format="🖴{used}/{total}G [{avail}G]")

# Shows Spotify song
status.register("custom_spotify",format="🎶{song}{artist}",interval=3)

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",

    on_leftclick="switch_mute")

# weather
status.register("custom_weather",format="{weather}")
	
status.run()
