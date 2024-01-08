# Define the list of commands for hyprpm
set -l hyprpm_commands add remove enable disable update reload list

# Basic completions for hyprpm
complete -c hyprpm -f

# Command completions with descriptions
complete -c hyprpm -n "not __fish_seen_subcommand_from $hyprpm_commands" -a add -d 'Install a new plugin repository from git'
complete -c hyprpm -n "not __fish_seen_subcommand_from $hyprpm_commands" -a remove -d 'Remove an installed plugin repository'
complete -c hyprpm -n "not __fish_seen_subcommand_from $hyprpm_commands" -a enable -d 'Enable a plugin'
complete -c hyprpm -n "not __fish_seen_subcommand_from $hyprpm_commands" -a disable -d 'Disable a plugin'
complete -c hyprpm -n "not __fish_seen_subcommand_from $hyprpm_commands" -a update -d 'Check and update all plugins if needed'
complete -c hyprpm -n "not __fish_seen_subcommand_from $hyprpm_commands" -a reload -d 'Reload hyprpm state and ensure all enabled plugins are loaded'
complete -c hyprpm -n "not __fish_seen_subcommand_from $hyprpm_commands" -a list -d 'List all installed plugins'

# Flag completions
complete -c hyprpm -l notify -s n -d 'Send a Hyprland notification for important events'
complete -c hyprpm -l help -s h -d 'Show help menu for hyprpm'
complete -c hyprpm -l verbose -s v -d 'Enable verbose logging'

