function idle_handler --description 'Wrapper for script that manages idle and automatic lock/suspend'
        
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
                set time_lock 10
                set time_speakers_off (math $time_lock - 3)
                set time_dpms_off ( math $time_lock + 5)
                set time_suspend ( math $time_dpms_off + 5)
        end

        if not set -q _flag_debug
                set time_lock 600
                set time_speakers_off (math $time_lock - 5)
                set time_dpms_off ( math $time_lock + 600)
                set time_suspend ( math $time_dpms_off + 600)
        end
        

        set -l cmd_lock 'swaylock -f  --screenshots  --clock  --indicator  --indicator-radius 100  --indicator-thickness 7  --effect-blur 7x5  --effect-vignette 0.5:0.5  --ring-color bbbbbb  --key-hl-color 880033  --line-color 00000000  --inside-color 00000000  --separator-color 00000000  --grace 2  --fade-in 0.2'
        
        #NOTE: DPMS setting in wayland is the WMs job, so change this when switching!
        set -l cmd_dpms_on 'hyprctl dispatch dpms on'
        set -l cmd_dpms_off 'hyprctl dispatch dpms off'
        
        set -l cmd_speakers_off 'fish -c "speakers -0"'
        
        set -l cmd_suspend 'systemctl suspend'


        if pidof swayidle 2&>/dev/null
                killall -9 swayidle &
        end

        swayidle -w \
                timeout $time_speakers_off $cmd_speakers_off \
                timeout $time_lock $cmd_lock \
                timeout $time_dpms_off $cmd_dpms_off \
                        resume $cmd_dpms_on \
                timeout $time_suspend $cmd_suspend \
                before-sleep $cmd_lock &
end
