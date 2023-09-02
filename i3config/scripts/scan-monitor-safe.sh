#!/bin/sh
mkdir -p $HOME/.tmp/pids
pidfile=$HOME/.tmp/pids/scan-monitor.pid

if [ -f "$pidfile" ] && kill -0 `cat $pidfile` 2>/dev/null; then
  exit 1
fi  
echo $$ > $pidfile

while true
do
  # Update xmodmap
  /usr/bin/xmodmap $HOME/.Xmodmap

  # Scan monitor
  detected=$(autorandr --detected)
  current=$(autorandr --current)
  
  if [ ! *"$detected"* == *"laptop"* ] && [ "$detected" ] && [ "$detected" != "$current" ]
  then
    sleep 2
    autorandr --change
    $HOME/.fehbg
  fi
  sleep 5
done
