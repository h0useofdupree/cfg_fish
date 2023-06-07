function idle_handler --description 'Wrapper for script that manages idle and automatic lock/suspend'
        
        argparse -n idle_handler 'h/help' -- $argv
        or return

        set -l time_lock 600
        set -l time_speakers_off (math $time_lock - 5)
        set -l time_dpms_off ( math $time_lock x 3)
        set -l time_suspend ( math $time_dpms_off x 2)

        # NOTE: Slock uses swaylock, which in return is wayland exclusive
        set -l cmd_lock 'swaylock  --screenshots  --clock  --indicator  --indicator-radius 100  --indicator-thickness 7  --effect-blur 7x5  --effect-vignette 0.5:0.5  --ring-color bbbbbb  --key-hl-color 880033  --line-color 00000000  --inside-color 00000000  --separator-color 00000000  --grace 2  --fade-in 0.2'
        # NOTE: DPMS setting in wayland is the WMs job, so change this when switching!
        set -l cmd_dpms_on 'hyprctl dispatch dpms on'
        set -l cmd_dpms_off 'hyprctl dispatch dpms off'
        # TODO: bashell-ize speakers script
        set -l cmd_speakers_off 'fish -c "speakers -0"'
        # NOTE: Resumung suspend can be a bit buggy and unreliable. Figure out if this is a systemd error or Hyprlands / swayidles fault.
        set -l cmd_suspend 'systemctl suspend'


        if pidof swayidle 2&>/dev/null
                killall -9 swayidle &
        end

        swayidle -w \
                # timeout $time_speakers_off $cmd_speakers_off \
                timeout $time_lock $cmd_lock \
                timeout $time_dpms_off $cmd_dpms_off \
                # timeout $time_suspend $cmd_suspend \
                resume $cmd_dpms_on \
                # before-sleep $cmd_lock &
                &
end
