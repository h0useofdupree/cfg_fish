function btop --wraps=btop --description 'Launches btop and sets padding in kitty to 0'
  if not status is-login && test $TERM = "xterm-kitty"
    kitty @ set-spacing padding=0
    
    command btop $argv
    
    kitty @ set-spacing padding=default
  else if not status is-login
    command btop $argv
  else
    command btop $argv
  end
end

