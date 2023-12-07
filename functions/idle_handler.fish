function idle_handler --description 'Wrapper for script that manages idle and automatic lock/suspend'
        
        set -f time_lock 600
        set -f time_speakers_off (math $time_suspend - 5)
        set -f time_dpms_off ( math $time_lock + 600)
        set -f time_suspend ( math $time_dpms_off + 600)

        
        argparse -n idle_handler 'h/help' 'r/restart' 'debug' -- $argv
        or return


        if set -q _flag_r
                echo 'Restarting idle_handler'
                killall swayidle
                idle_handler
                echo 'New pid of swayidle:' (pidof swayidle)
                return
        end

        if set -q _flag_debug
                echo 'Restarting idle_handler in debug mode'
                if pidof swayidle &>/dev/null
                        killall swayidle
                end
                set -f time_lock 5
                set -f time_speakers_off (math $time_lock - 3)
                set -f time_dpms_off ( math $time_lock + 5)
                set -f time_suspend ( math $time_dpms_off + 5)
        end

        
        if test $XDG_CURRENT_DESKTOP = 'Hyprland'
                set -f cmd_dpms_on 'hyprctl dispatch dpms on'
                set -f cmd_dpms_off 'hyprctl dispatch dpms off'
                
                set -f cmd_speakers_off 'fish -c "speakers -0"'
                
                set -f cmd_suspend 'systemctl suspend'
        else
                echo 'Commands for '$XDG_CURRENT_DESKTOP' not found'
                notify-send 'Idle Handler' 'Commands for '$XDG_CURRENT_DESKTOP' not found'
                return 1
        end


        if pidof swayidle 2&>/dev/null
                killall -9 swayidle &
        end

        swayidle -w \
                timeout $time_speakers_off $cmd_speakers_off \
                timeout $time_lock 'fish -c slock' \
                timeout $time_dpms_off $cmd_dpms_off \
                        resume $cmd_dpms_on \
                timeout $time_suspend $cmd_suspend \
                before-sleep 'fish -c slock' &
end
