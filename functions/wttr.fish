function wttr --description 'Wrapper for curl wttr.in'
  echo  "  "(curl -s "wttr.in/Mettmann?format='%c%t'" | tr -d "'")"  "
end
