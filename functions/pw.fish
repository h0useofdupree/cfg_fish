function pw --description 'Pywal Wrapper for use with swww'
  wal -i ~/Pictures/walls/GIFs/city.gif -n --backend haishoku -a 55

  swww img ~/Pictures/walls/GIFs/japan.gif --outputs DP-6 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 144 
  swww img ~/Pictures/walls/GIFs/city.gif --outputs DP-4 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 60

  if test $CONNECTED_MONITORS -eq 1
    swww img ~/Pictures/walls/GIFs/city.gif --outputs eDP-1 --transition-type wipe --transition-angle 30 --transition-step 90 --transition-fps 60
  end
end
