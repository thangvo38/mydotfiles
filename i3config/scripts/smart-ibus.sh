#!/bin/bash
current_process_path=$HOME/.config/i3/scripts/smart-ibus-processid.txt
if [ -e $current_process_path ]; then
  current_process=$(cat $current_process_path)
  echo "Kiling process $current_process"
  kill -9 $current_process 2>/dev/null
fi

echo "Starting..."
echo $$ > $current_process_path

while read -r line
do
  WINDOW_ID="$(echo  $line | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')"
  NAME=$(xprop -id $WINDOW_ID | awk '/WM_CLASS/{$1=$2="";print}' | cut -d'"' -f4)

  # Handle firefox tabs
  if [[ $NAME == "firefox" ]]
  then
    PREV_TAB="" 
    while true; do
      new_window_line=$(xprop -root _NET_ACTIVE_WINDOW)
      NEW_WINDOW_ID="$(echo $new_window_line | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')"
      #echo "NewWindow $NEW_WINDOW_ID"
      #echo "Window $WINDOW_ID"

      if [[ $NEW_WINDOW_ID != $WINDOW_ID ]]; then
        NAME=$(xprop -id $NEW_WINDOW_ID | awk '/WM_CLASS/{$1=$2="";print}' | cut -d'"' -f4)
        break
      fi

      TAB=$(xprop -notype -id $WINDOW_ID WM_NAME)
      TAB_NAME="$(echo $TAB | cut -d'=' -f2 | cut -d'"' -f2)"
      #echo "Tab name $TAB_NAME"
      if [[ $PREV_TAB == $TAB_NAME ]]
      then
        PREV_TAB="$TAB_NAME"
        sleep 1
        continue
      fi

      PREV_TAB="$TAB_NAME"

      if [[ $TAB_NAME == *"Messenger | Facebook"* ]]
      then
        ibus engine Bamboo 2>/dev/null
      else 
        ibus engine BambooUs 2>/dev/null
      fi

      #sleep 0.2
    done
  fi

  # Handle other apps
  if [[ $NAME == "TelegramDesktop" ]]
  then
    ibus engine Bamboo 2>/dev/null
    continue
  fi

  ibus engine BambooUs 2>/dev/null
done < <(xprop -spy -root _NET_ACTIVE_WINDOW)

