if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # command cat ~/.cache/wal/sequences &
    # wal --theme base16-nord
    
    todo.sh list
    
    # Vi-Mode Easy Exit
    bind --mode insert --sets-mode default jj repaint
    
    # Vars
    set -gx GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH
    set -gx OPENAI_KEY "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" &
    set -Ux CONNECTED_MONITORS (wlr-randr | grep -c "Enabled")
end
