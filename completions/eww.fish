function __fish_eww_no_subcommand
    set -l cmd (commandline -opc)
    if [ (count $cmd) -eq 1 -a $cmd[1] = 'eww' ]
        return 0
    end
    return 1
end

complete -c eww -f
complete -c eww -n '__fish_eww_no_subcommand' -a daemon -d 'Start the eww daemon'
complete -c eww -n '__fish_eww_no_subcommand' -a open -d 'Open a widget'
complete -c eww -n '__fish_eww_no_subcommand' -a close -d 'Close a widget'
complete -c eww -n '__fish_eww_no_subcommand' -a reload -d 'Reload the current configuration'
complete -c eww -n '__fish_eww_no_subcommand' -a log -d 'Show the eww log'

