function restartWaybar
  if pidof &>/dev/null waybar
    killall waybar
  end
  nohup waybar -s $WAYBAR_STYLE &>/dev/null &
end
