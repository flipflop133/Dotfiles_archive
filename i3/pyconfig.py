from i3pystatus import Status
status = Status()

# Open Rofi power menu
status.register("power_menu")

# Displays clock
status.register("clock", format=" %X", color="#f38181")

# Displays date
status.register("custom_calendar",format=" {date}",interval=600, color="#95e1d3")

# weather
status.register("custom_weather",format="{weather}")

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load")

# Shows avg cpu freq
status.register("cpu_usage",format=" {usage}%",dynamic_color=True)

# Shows avg cpu temp
status.register("cputemp",format=" {temp}°C")

# Shows avg cpu temp
status.register("mem",format=" {used_mem}/{total_mem}Gb",divisor=1*(10**9))

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register("network",
    interface="enp3s0",
    format_up=" {v4cidr}",)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
    path="/",
    format="🖴 {used}/{total}G [{avail}G]")

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    color_unmuted="#ca7df9",
    format=" {volume}",
    on_leftclick="switch_mute")

# Shows Spotify song
status.register("custom_spotify",format=" {song}{artist}",interval=3)

# Displays window
#status.register("window_title")
	
status.run()
