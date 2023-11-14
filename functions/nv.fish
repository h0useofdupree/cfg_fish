function nv --wraps=nvim --description 'Launches nvim and sets padding in kitty to 0'
  if not status is-login && test $TERM = "xterm-kitty"
    kitty @ set-spacing padding=0
    kitty @ set-colors background=#1A1D23
    
    nvim $argv
    
    kitty @ set-spacing padding=default
    kitty @ set-colors --reset
  else if not status is-login
    nvim $argv
  else
    nvim $argv
  end
end
