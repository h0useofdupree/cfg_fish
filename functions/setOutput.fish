function setOutput --description 'Sets outputs based on number of diplays connected'
  set displayCount  getmon
  
  if $displayCount = 1
    echo 'Setting displays to laptop only'
    hyprctl keyword monitor "eDP-1, preferred, auto, 1"
  else if $displayCount = 3
    echo 'Setting displays to multihead'
    hyprctl keyword monitor "eDP-1, disable"
    hyprctl keyword monitor "DP-6, 1920x1080@144, 0x0, 1"
    hyprctl keyword monitor "DP-4, 1680x1050@59, 1920x0, 1"
  else
    echo 'Setting automatic displays'
    hyprctl keyword monitor ",preferred, auto, 1"
  end
end
