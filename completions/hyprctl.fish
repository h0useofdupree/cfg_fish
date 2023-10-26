## hyprctl
complete -c hyprctl -a 'monitors workspaces activeworkspace clients activewindow layers devices binds dispatch keyword version kill splash hyprpaper reload setcursor getoption cursorpos switchxkblayout seterror setprop plugin notify globalshortcuts'
complete -c hyprctl -f
complete -c hyprctl -s j -d 'output in JSON'
complete -c hyprctl -l batch -d 'execute batch of commands seperated by ";"'

