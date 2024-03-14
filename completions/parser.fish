function __fish_parser_needs_command
    set cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

function __fish_parser_using_command
    set cmd (commandline -opc)
    if contains -- $argv[1] $cmd
        return 0
    end
    return 1
end

# Completion for the main parser command
complete -f -c parser -n '__fish_parser_needs_command' -a 'view' -d 'View command help'
complete -f -c parser -n '__fish_parser_needs_command' -a 'analyze' -d 'Analyze command help'
complete -f -c parser -s 'h' -l 'help' -d 'Show help menu'

# Completions for "view" command
complete -c parser -n '__fish_parser_using_command view' -s 'c' -l 'column' -d 'Column to display, in Excel format (e.g., A, B, ... AA, AB, ...)' -x -a '(python3 /home/juuls/.scripts/generate_excel_columns.py)'
complete -f -c parser -n '__fish_parser_using_command view' -s 's' -l 'subcolumn' -d 'Index of the subcolumn to display, relative to the main column' -x
complete -f -c parser -n '__fish_parser_using_command view' -s 'r' -l 'row' -d 'Index of the row to display, where n = 0-amount of rows'
complete -f -c parser -n '__fish_parser_using_command view' -s 't' -l 'types' -d 'Shows the dtype of the fields' -f
complete -f -c parser -n '__fish_parser_using_command view' -s 'v' -l 'verbose' -d 'Output all rows and columns' -f

# Completions for "analyze" command
complete -f -c parser -n '__fish_parser_using_command analyze' -l 'save' -d 'Save analysis results in file analysis_summary.csv' -f
complete -f -c parser -n '__fish_parser_using_command analyze' -s 'v' -l 'verbose' -d 'Output all rows and columns' -f
