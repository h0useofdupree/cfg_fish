# Define the list of primary commands
set -l commands activewindow activeworkspace binds clients cursorpos devices dispatch getoption globalshortcuts hyprpaper instances keyword kill layers layouts monitors notify plugin reload setcursor seterror setprop splash switchxkblayout version workspacerules workspaces

# Basic completions for hyprctl
complete -c hyprctl -f

# Command completions
for cmd in $commands
    complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a $cmd -d "description for $cmd"
end

# Subcommands and specific completions
complete -c hyprctl -n "__fish_seen_subcommand_from monitors" -a "all" -d "Show all outputs, including disabled ones"
complete -c hyprctl -n "__fish_seen_subcommand_from dispatch" -a "exec killactive workspace movetoworkspace movetoworkspacesilent togglefloating fullscreen pseudo movefocus movewindow resizeactive moveactive cyclenext focuswindowbyclass focusmonitor splitratio movecursortocorner workspaceopt exit forcerendererreload movecurrentworkspacetomonitor moveworkspacetomonitor togglespecialworkspace" -d "Dispatch subcommands"

# Global flag completions
complete -c hyprctl -l batch -d 'Specify a batch of commands to execute; separated by ";"'
complete -c hyprctl -s j -d 'Output in JSON format'
complete -c hyprctl -l instance -s i -d 'Use a specific instance (signature or index)'

# Add descriptions for each primary command
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a activewindow -d 'Gets the active window name'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a layers -d 'lists all the layers'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a devices -d 'lists all connected keyboards and mice'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a dispatch -d 'call a keybind dispatcher'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a keyword -d 'call a config keyword dynamically'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a version -d 'prints the hyprland version'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a kill -d 'kill an app by clicking on it'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a reload -d 'issue a reload to force reload the config'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a monitors -d 'lists all the outputs with their properties'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a workspaces -d 'lists all workspaces with their properties'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a globalshortcuts -d 'find out what this does'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a clients -d 'lists all windows with their properties'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a layouts -d 'Manage or switch between different window layouts'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a notify -d 'Send a notification or manage notification settings'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a plugin -d 'Manage or interact with Hyprland plugins'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a setcursor -d 'Set the cursor style or properties'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a seterror -d 'Set or display error-related information'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a setprop -d 'Set properties for various Hyprland elements'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a splash -d 'Manage or display splash screens'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a switchxkblayout -d 'Switch between different keyboard layouts'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a workspacerules -d 'Define or manage rules for workspaces'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a instances -d 'List or manage Hyprland instances'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a hyprpaper -d 'Manage or interact with Hyprpaper, the wallpaper manager'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a getoption -d 'Retrieve configuration options or settings'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a cursorpos -d 'Get or set the cursor position'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a binds -d 'List or manage keyboard/mouse bindings'
complete -c hyprctl -n "not __fish_seen_subcommand_from $commands" -a activeworkspace -d 'Display information about the active workspace'
