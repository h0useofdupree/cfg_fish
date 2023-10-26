function restartFootServer --description 'Restart foot server'
  killall foot
  foot --server &>/dev/null
end
