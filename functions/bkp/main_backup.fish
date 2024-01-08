function main_backup --description 'Uses bkp function do backup directories in $main_backup_dir_list'
  # Argparse
  argparse 'h/help' 'f/force' 'q/quiet' 'd/dry' -- $argv
  or return

  set -l backup_logo ~/Pictures/backup-logo.png
  
  notify-send -i $backup_logo "Backup" "Backup process started."
  
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
          --exclude-from $exclude_from

    if set -q _flag_quiet
      set rclone_cmd "$rclone_cmd --quiet"
    end

    if set -q _flag_dry
      set rclone_cmd "$rclone_cmd --dry"
    end

    if set -q _flag_force
      set rclone_cmd "$rclone_cmd --force"
    end

    if set -q _flag_quiet
      eval $rclone_cmd 2&>/dev/null
    else
      eval $rclone_cmd
    end
    
    if test $status -eq 130
      return 1
    end
  end
  echo "Made backup for: $main_backup_dir_list" > ~/.config/rclone/logs/main_backup_(date '+%Y-%m-%d-%H-%M').log
  notify-send -i $backup_logo "Backup" "Backup process finished."
end
