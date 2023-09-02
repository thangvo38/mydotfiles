#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

NID=0
function send_notification {
    volume=`get_volume`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
    # Send the notification
    #dunstify -i audio-volume-muted-blocking -t 8 -u normal "    $bar"
    NID=$(dunstify -p -r $NID "Volume $volume%")
}

case $1 in
    up)
	# Set the volume on (if it was muted)
    
	    pactl set-sink-volume @DEFAULT_SINK@ +5%
	    send_notification
	;;
    down)	
		pactl set-sink-volume @DEFAULT_SINK@ -5%
		send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
			pactl set-sink-mute @DEFAULT_SINK@ toggle
	else
	    send_notification
	fi
	;;
esac
