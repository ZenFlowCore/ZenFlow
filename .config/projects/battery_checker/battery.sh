#!/bin/bash
THRESHOLD_VERY_LOW=10
THRESHOLD_LOW=30
THRESHOLD_MEDIUM=35
POLL_INTERVAL_HIGH=600   # 10 minutes in seconds
POLL_INTERVAL_MEDIUM=60    # 1 minute in seconds
POLL_INTERVAL_LOW=300
POLL_INTERVAL_VERY_LOW=60

while true; do
  BATTINFO=`cat /sys/class/power_supply/BAT0/capacity`

  if (( BATTINFO <= THRESHOLD_LOW )); then
    PID=$(pgrep -f "alarm.py")
    if [ -n "$PID" ]; then
      echo "Killing existing alarm.py process (PID: $PID)"
      kill "$PID"
    fi
    echo "Battery low ($BATTINFO). Starting Python script..."
    python3 /home/zen/.dotfiles/battery_checker/alarm.py &
    sleep "$POLL_INTERVAL_LOW"
  elif (( BATTINFO <= THRESHOLD_VERY_LOW )); then
      PID=$(pgrep -f "alarm.py")
      if [ -n "$PID" ]; then
        echo "Killing existing alarm.py process (PID: $PID)"
        kill "$PID"
      fi
      echo "Battery low ($BATTINFO). Starting Python script..."
      python3 /home/zen/.dotfiles/battery_checker/alarm.py &
      sleep "$POLL_INTERVAL_VERY_LOW"

  elif (( BATTINFO < THRESHOLD_MEDIUM )); then
    echo "Battery between $THRESHOLD_LOW and $THRESHOLD_MEDIUM ($BATTINFO). Checking more frequently..."
    sleep "$POLL_INTERVAL_MEDIUM"
  else
    echo "Battery above $THRESHOLD_MEDIUM ($BATTINFO). Checking less frequently..."
    sleep "$POLL_INTERVAL_HIGH"
  fi
done
