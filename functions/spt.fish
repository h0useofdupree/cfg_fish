function spt --description 'wrapper for spotify_player'
  if not status is-login && test $TERM = "xterm-kitty"
    kitty @ set-spacing padding=10
    spotify_player $argv
    kitty @ set-spacing padding=default
  else if not status is-login
    spotify_player $argv
  else
    spotify_player $argv
  end
end
