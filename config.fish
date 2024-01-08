if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # command cat ~/.cache/wal/sequences &
    # wal --theme base16-nord
    
    todo.sh list
    
    # Vi-Mode Easy Exit
    bind --mode insert --sets-mode default jj repaint
    
    # Vars
    set -gx EDITOR nvim
    set -gx BROWSER qutebrowser
    
    set -gx GOPATH $HOME/go
    set -gx EMACSBINPATH ~/.config/emacs/bin
    set -gx PATH $GOPATH/bin $EMACSBINPATH ~/.cargo/bin/ $PATH
    
    set -Ux CONNECTED_MONITORS (wlr-randr | grep -c "Enabled")
    
    set -gx main_backup_dir_list \
            ~/.config/ \
            ~/Pictures \
            ~/Documents \
            ~/.scripts \
            ~/sec \
            ~/Projects
    
    set -gx theme catppuccin
    set -gx theme_flavor mocha
    set -gx wallpaper_folder $HOME/Pictures/walls/forest/

    # Add subfolders from ./functions to $fish_function_path
    set -p fish_function_path ~/.config/fish/functions/bkp
end
