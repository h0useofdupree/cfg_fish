function pws --description 'Pywal Wrapper for use with swww. Sets images via argv path'
  if test -z $argv
    echo 'Provide at least one argument'
    return 1
  end

  set -l WALL $argv
  
    
  wal -i $WALL -n --backend haishoku -a 55

  # swww img $WALL --outputs DP-6 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 144 
  # swww img $WALL --outputs DP-4 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 60

  if test $CONNECTED_MONITORS -eq 1
    swww img $WALL --outputs eDP-1 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 60
  end
  restartWaybar &>/dev/null &
end
