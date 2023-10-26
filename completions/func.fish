function __fish_func_complete_function_names
    for file in ~/.config/fish/functions/*.fish
        echo (basename $file .fish)
    end
end

complete -f -c func -a '(__fish_func_complete_function_names)'
