from i3pystatus import Status
status = Status()

# Open Rofi power menu
status.register("power_menu", color="#ffffff")

# Displays clock
status.register("clock", format=" %I:%M", color="#ffffff")

# Displays date
status.register("custom_calendar",
                format=" {date}",
                interval=600,
                color="#ffffff")

# weather
status.register("custom_weather", format="{weather}")

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
# status.register("load")

# Shows avg cpu usage
status.register("cpufreq", format=" {freq}Ghz", color="#ffffff")

# Shows avg cpu usage
status.register("cpu_usage", format=" {usage}%")

# Shows avg cpu temp
status.register("cputemp", format=" {temp}°C", color="#ffffff")

# Shows avg cpu temp
status.register("mem",
                format=" {used_mem}Gb",
                divisor=1 * (10**9),
                color="#ffffff")

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
# status.register(
#     "network",
#     interface="enp3s0",
#     format_up=" {v4cidr}",
# )

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk", path="/", format=" {used}/{total}G [{avail}G]")

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
                color_unmuted="#ffffff",
                format=" {volume}",
                on_leftclick="switch_mute")

# Shows Spotify song
status.register("custom_spotify",
                format=" {song}{artist}",
                interval=3,
                color="#ffffff")

# Displays window
# status.register("window_title")

status.run()
