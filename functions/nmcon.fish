function nmcon --description 'Shortcut for connecting to known WiFi networks'
  echo 'Connecting to network '$argv
  echo
  if nmcli device wifi connect $argv
    echo
    echo 'Successfully connected to '$argv'.' | lolcat -a
  else if test $status -eq 2
    echo
    echo 'You idiot forgot the SSID, shame!'
  end
end
