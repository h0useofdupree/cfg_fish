function main_backup --description 'Uses bkp function do backup directories in $main_backup_dir_list'
  # Argparse
  argparse 'h/help' 'f/force' 'q/quiet' -- $argv
  or return
  

  # if set -q _flag_force
  # end
  #
  # if set -q _flag_quiet
  # end
  
  notify-send "Backup Main" "Starting main backup process"
  for dir in $main_backup_dir_list
    set -l last_char (string sub -s -1 $dir)
    if not test $last_char = '/'
      set dir $dir"/"
    else
      set dir $dir
    end

    set -l exclude_from $dir".rclone_exclude.txt"
    
    set -l from_folder_local $dir
    set -l to_folder_cloud "bkp-xps15:/bkp-xps15/"(string replace -r '^(/home/juuls/|~/)' '' -- $dir)
    set -l log_path $dir
    
    # # Add / to path if not present
    # set -l last_char (string sub -s -1 $dir)
    # if not test $last_char = '/'
    #   set dir $dir"/"
    # end
    

    set -l rclone_cmd bkp \
          --mode sync \
          --from $from_folder_local \
          --to $to_folder_cloud \
          -t 10 \
          -r 5 \
          --drive-chunk-size 2048 \
          --fast-list \
          --follow-symlinks \
          -p \
          --progress-terminal-title \
          --log $log_path \
          --delete-excluded \
          --force \
          --exclude-from $exclude_from
          #TODO: Add option parsing
          # --dry \
          # -q
    eval $rclone_cmd 
    if test $status -eq 130
      return 1
    end
    # sleep 1
  end
  echo "Made backup for: $main_backup_dir_list" > ~/.config/rclone/logs/main_backup_(date '+%Y-%m-%d-%H-%M').log
  notify-send "Backup Main" "Finished backup"
end
