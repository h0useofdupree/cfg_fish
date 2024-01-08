function wp --description 'simply random wallpaper'
  argparse 'h/help' 'w/wallpaper=' -- $argv
  or return

  set -f transition wipe
  set -f transition_fps 144
  set -f transition_step 255
  set -f transition_duration 1.5
  
  
  if set -q _flag_w
    set -f imgpath $_flag_w
  else 
    set -f imgpath $wallpaper_folder
  end
  swww img \
    (find $wallpaper_folder -type f | shuf -n1)\
    -t $transition \
    --transition-fps $transition_fps \
    --transition-step $transition_step \
    --transition-duration $transition_duration 
end
