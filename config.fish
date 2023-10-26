if status is-interactive
    # Commands to run in interactive sessions can go here
    # NOTE: Escape the fish function 'cat' which is used as a wrapper for 'bat'
    command cat ~/.cache/wal/sequences &
    
    todo.sh list &
    source ~/.config/openaikey.fish
    
    bind --mode insert --sets-mode default jj repaint
    # Vars
    set -gx GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH

    set -U CONNECTED_MONITORS (wlr-randr | grep -c "Enabled")

end
