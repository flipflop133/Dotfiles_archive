from pathlib import Path
home = str(Path.home())
import sys
from retrieveGtkColors import getThemeColors

gtkThemeColors = getThemeColors()
tmpTheme = {
    "set $bg": gtkThemeColors["theme_bg_color"],
    "set $fg": gtkThemeColors["theme_fg_color"],
    "set $black": gtkThemeColors["theme_fg_color"],
    "set $sel_bg_color": gtkThemeColors["theme_selected_bg_color"],
    "set $sel_fg_color": gtkThemeColors["theme_selected_fg_color"],
    "set $red": gtkThemeColors["error_color"]
}

tmpTheme2 = []
for line in tmpTheme:
    tmpTheme2.append(line + '\t' + tmpTheme[line])

# Read command line arguments
selectedTheme = sys.argv[1]

theme = open(home + "/.config/sway/" + selectedTheme + "Theme", 'r')

count = 0
replace = False
buffer = []
for line in theme:
    if line != "\n":
        if line == "# set colors\n":
            replace = False
        if replace:
            line = tmpTheme2[count] + "\n"
            count += 1
        if line == "# define colors\n":
            replace = True
    buffer.append(line)

# Write theme to real config file
data = open(home + "/.config/sway/" + selectedTheme + "Theme", 'w')
for i in range(len(buffer)):
    data.write(buffer[i])
data.close()
