pactl get-source-mute @DEFAULT_SOURCE@ | awk '/Mute: no/ {print "Mic ON"}'
