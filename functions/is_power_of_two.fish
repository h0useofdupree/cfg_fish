function is_power_of_two
    set -l num_string (string match -r '^[0-9]+' -- $argv)
    set -l num (math $num_string)

    if test $num -le 0
        return 1
    end

    while test (math "$num % 2") -eq 0
        set num (math "$num / 2")
    end

    if test $num -eq 1
        return 0
    else
        return 1
    end
end
