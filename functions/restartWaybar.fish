function restartWaybar
  if pidof &>/dev/null waybar
    killall waybar
  end
  nohup waybar &>/dev/null &
end
