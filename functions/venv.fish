function venv --description 'Shortcut that creates local venv and install requirements'
  python3 -m venv venv
  if test -n ./venv/bin/activate.fish
    source ./venv/bin/activate.fish 
  else
    echo '"activate.fish" not found. Did you initialize the venv?'
  end
  if test -e ./requirements.txt
    pip install -r requirements.txt
  else
    echo '"requirements.txt" not found, are you in the correct directory?'
  end
end
