function x --description 'All in one script for setting wallpaper, changing theme and restarting elements using said theme'
  if test -z $argv
    return 1
  end
  set -l WALL ~/Pictures/walls/GIFs/$argv.gif
  
  if set -q flag_h
    echo "
    x - All in one script for setting wallpaper, changing theme and restarting elements using said theme 
    List of wallpapers:
      city
      japan
    "
  end 
  
end
