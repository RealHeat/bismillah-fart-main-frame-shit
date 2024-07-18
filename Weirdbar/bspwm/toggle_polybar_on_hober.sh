#!/bin/bash

POLYBAR_NAME="example" #put the name of your polybar
ACTIVATION_ZONE=10  #the ditance in within you want the polybar to activate
SCREEN_HEIGHT=800  #your screen height 
POLYBAR_RUNNING=false #boolean
WAIT_TIME=3 # time it takes for polybar to close
REFRESH=1 #how often you want it to check for cursor position

while true; do
  # cursor
  sleep ${REFRESH}s &&
  eval $(xdotool getmouselocation --shell)   
  # check
  if [ "$Y" -ge "$(($SCREEN_HEIGHT - $ACTIVATION_ZONE))" ]; then
    if ! $POLYBAR_RUNNING; then
      echo "Starting Polybar"
      polybar $POLYBAR_NAME &
      POLYBAR_RUNNING=true
    fi
  else
    if $POLYBAR_RUNNING; then
      echo "Stopping Polybar"
      sleep ${WAIT_TIME}s && killall polybar && bspc config -m focused bottom_padding 0 & 
      POLYBAR_RUNNING=false
    fi
  fi
       
done
