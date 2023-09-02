#!/bin/sh
while true
do
  modes=$(autorandr)
  should_reset=true

  SAVEIFS=$IFS   # Save current IFS (Internal Field Separator)
  IFS=$'\n'      # Change IFS to newline char
  modes=($modes) # split the `names` string into an array by the same name
  IFS=$SAVEIFS   # Restore original IFS

  for (( i=0; i<${#modes[@]}; i++ ))
  do
    mode_check=$(echo ${modes[$i]} | grep -E "detected.*current*")

    if [ ! -z "$mode_check" ]
    then
      should_reset=false
      break
    fi
  done

  if $should_reset
  then
    i3-msg -s $(i3 --get-socket) restart
  fi
  sleep 2
done
