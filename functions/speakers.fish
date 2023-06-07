function speakers --description 'Turns on or off speakers via webhook'
    set -l args "h/help" "#p"
    argparse $args -- $argv
    or return 

    set -l url_speakers_on 'https://maker.ifttt.com/trigger/pc_speakers_on/json/with/key/pzJJnb6wYJWs6VRh1LDt0UXZNn-SDmMa7RhdSEY9a2v'
    set -l url_speakers_off 'https://maker.ifttt.com/trigger/pc_speakers_off/json/with/key/pzJJnb6wYJWs6VRh1LDt0UXZNn-SDmMa7RhdSEY9a2v'

    if set -q _flag_h
        echo 'Turn on or off your speakers via webhooks predefined in fish variables'
        echo
        echo 'Simply pass either -1 (on) or -0 (off)'
    end

    if set -q _flag_p
        # Exact state by argument
        if test $_flag_p -eq 1
            curl -X POST $url_speakers_on 2&>/dev/null
        else if test $_flag_p -eq 0
            curl -X POST $url_speakers_off 2&>/dev/null
        end
    else
        # Return 1 if no arg is given
        echo 'speakers requires at least 1 argument'
        return 1
    end
end
