let outer_bar_pid = (
    hyprctl layers
    | lines 
    | find 'outer-bar'
    | first     
    | str find-replace --regex '.*outer-bar,\s*pid:\s*(\d+).*' '$1' )

print $"Outer-bar PID: ($outer_bar_pid)"

if ($outer_bar_pid | is-not-empty) {
    print $"Killing process ($outer_bar_pid)..."
    kill $outer_bar_pid
    sleep 100ms # Small delay (100 milliseconds) for cleanup
} else {
    print "Outer-bar PID not found."
}

print "Relaunching outer-bar..."
do 'python3 ~/dotfiles/.config/projects/fabric_bar/bar.py' &
