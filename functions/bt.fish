function bt --description 'btop wrapper with custom kitty margins'
  kitty @ set-spacing padding=10
  btop
  kitty @ set-spacing padding=default
end
