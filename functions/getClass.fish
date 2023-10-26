function getClass --description 'Returns class name and ID of window'
set -l WINDOW_ID (xdotool getactivewindow)
set -l CLASS_NAME (xprop -id $WINDOW_ID | rg WM_CLASS | cut -d '"' -f2)
echo $CLASS_NAME
end
