function nv --wraps nvim --description 'Launches nvim and sets padding in kitty to 0'
  if not status is-login && test $TERM = "xterm-kitty"
    kitty @ set-spacing padding=0
    nvim $argv
    kitty @ set-spacing padding=default
  else if not status is-login
    nvim $argv
  else
    nvim $argv
  end
end
