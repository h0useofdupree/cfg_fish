function getmon --description 'Returns amount of connected displays'
xrandr -q | grep ' connected' -c
end
