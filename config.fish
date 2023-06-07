if status is-interactive
    # Commands to run in interactive sessions can go here
    bass "(cat ~/.cache/wal/sequences &)"

    colorscript -r
    
    abbr -a nv nvim
    abbr -a func "funced -e nvim -s"
    abbr -a t 'todo.sh'
    abbr -a cdh 'cd ~/.config/hypr/'


    set -U CONNECTED_MONITORS (wlr-randr | grep -c "Enabled")
end
