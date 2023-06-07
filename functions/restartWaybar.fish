function restartWaybar
  killall waybar
  waybar 2&>/dev/null
end
