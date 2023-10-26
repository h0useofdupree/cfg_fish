function pwm --description 'Pywal Wrapper for use with swww'
  set -l img $argv
  
  wal -i $img -n --backend haishoku -a 100

  swww img $img --outputs eDP-1 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 144 &

  restartWaybar &>/dev/null &
end
