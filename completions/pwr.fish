# --- Helper functions for conditions ---

# Check if a subcommand is needed
function __fish_pwr_needs_subcommand
    set -l cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

# Check if the 'backend' subcommand is being used
function __fish_pwr_using_backend_subcommand
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 1; and test "$cmd[2]" = "backend"
        return 0
    end
    return 1
end

# --- pwr main command and options ---

# Main command options
complete -c pwr -s h -l help -d "ⓘ Help" -f
complete -c pwr -s a -l alpha -d "🔢 Alpha Level" -f
complete -c pwr -s w -l wallpaper -d "🖼 Wallpaper Path" -F
complete -c pwr -s b -l background -d "🧱 Background Color (#XXXXXX)" -f

# Backend as a subcommand
complete -c pwr -n "__fish_pwr_needs_subcommand" -a "backend" -d "🎨 Choose Backend" -f

# --- Backend-specific completions ---

complete -c pwr -n '__fish_pwr_using_backend_subcommand' -a "wal" -d "🌀 wal" -f
complete -c pwr -n '__fish_pwr_using_backend_subcommand' -a "colorz" -d "🌈 colorz" -f
complete -c pwr -n '__fish_pwr_using_backend_subcommand' -a "colorthief" -d "🔍 colorthief" -f
complete -c pwr -n '__fish_pwr_using_backend_subcommand' -a "haishoku" -d "🌸 haishoku" -f
complete -c pwr -n '__fish_pwr_using_backend_subcommand' -a "schemer2" -d "🎨 schemer2" -f

