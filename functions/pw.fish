function pw --description 'Pywal Wrapper for use with swww'
  set -l primary ~/Pictures/walls/GIFs/jap-city.gif
  set -l secondary $primary
  
  wal -i $primary -n --backend haishoku -a 100

  swww img $primary --outputs DP-6 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 144 &
  swww img $secondary --outputs DP-4 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 60 &

  restartWaybar &>/dev/null &
end
