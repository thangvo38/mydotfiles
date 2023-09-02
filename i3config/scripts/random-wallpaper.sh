#!/bin/sh
directory="/usr/share/backgrounds/random"
prev_file=""
while true
do
  random_file=$(find "$directory" -type f -print0 | shuf -zn 1 -z | xargs -0 echo)
  if [[ $prev_file != $random_file ]]
  then
    prev_file=$random_file
    feh --bg-scale $random_file
    sleep $1
  fi
done
