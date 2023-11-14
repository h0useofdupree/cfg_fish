function func
    set functions_dir ~/.config/fish/functions

    if test (count $argv) -eq 0
        echo "Please provide a function name to edit."
        return 1
    end

    set function_name $argv[1]
    set function_path $functions_dir/$function_name.fish

    if not test -e $function_path
        echo "Function file $function_name.fish does not exist in $functions_dir"
        return 1
    end

    # Open the function with the default editor
    nv $function_path
end
