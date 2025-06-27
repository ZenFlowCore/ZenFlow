PID=$(hyprctl layers | grep -oP 'outer-bar,\s*pid:\s*\K\d+')

if [ -n "$PID" ]; then
  echo "Found outer-bar with PID: $PID. Killing it..."
  kill "$PID"
  # Optional: Add a small delay to ensure the old process fully cleans up
  sleep 0.1
else
  echo "outer-bar process not found or already stopped."
fi
