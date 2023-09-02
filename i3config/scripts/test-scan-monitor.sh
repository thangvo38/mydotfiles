#!/bin/sh
while true
do
  # Update xmodmap
  /usr/bin/xmodmap $HOME/.Xmodmap

  # Scan monitor
  detected=$(autorandr --detected)
  current=$(autorandr --current)
  echo "$detected" "$current"
 
  if [ ! *"$detected"* == *"laptop"* ] && [ "$detected" ] && [ "$detected" != "$current" ]
  then
    echo "Refresh screen"
  fi
  sleep 5
done
