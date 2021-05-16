########
# SWAY #
########
# If running from tty1 start sway
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec env _JAVA_AWT_WM_NONREPARENTING=1 sway
fi

