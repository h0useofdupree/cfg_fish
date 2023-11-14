# vim:foldmethod=manual
function bkp --description 'Backup using rclone'
  # Argparse
  argparse 'h/help' \
					 'm/mode=' \
					 'from=' \
					 'to=' \
					 't/transfers=' \
					 'r/retries=' \
					 'drive-chunk-size=' \
					 'fast-list' \
					 'follow-symlinks' \
					 'p/progress' \
					 'progress-terminal-title' \
					 'e/exclude-from=' \
					 'log=' \
	         'dry' \
	         'force' \
	         'delete-excluded' \
	         'q/quiet' -- $argv
  or return
  

  # Script variables
  set -l date (date '+%Y-%m-%d-%H-%M-%S')
  set -l max_transfers 15
  set -l max_retries    5

  
  # Argument defaults
  set -l mode sync

  set -l from_folder_local "/home/juuls/.config/"
  set -l to_folder_cloud "bkp-xps15:/bkp-xps15/.config/"
  
  set -l transfers 20
  set -l retries 5
  set -l drive_chunk_size 1024M
  set -l fast_list false
  set -l follow_symlinks true
  set -l delete_excluded false
  
  set -l progress true
  set -l progress_terminal_title true
  
  set -l exclude_file ~/.config/.rclone_exclude.txt
  #TODO: Rename to log_dir
  set -l log_folder ".rclone_logs/"
  set -l log_file $date".log"
  

  function _notify --no-scope-shadowing -d 'Send notification if not in login shell'
    if not status is-login
      notify-send "BKP" $notify_text
    end
    functions -e _notify
  end
 
  function _print_error --no-scope-shadowing -d 'Print Error Message'
    if test -n $error
      echo \n\n"ERROR:" $print_error_text \n\n
    end
    functions -e _print_error
  end

  function _create_log_dir --no-scope-shadowing -d 'Create rclone logs directory'
    if not test -e $log_path
      mkdir -p $log_path
    end
    functions -e _create_log_dir
  end

  function _list_cmd_arguments --no-scope-shadowing -d 'List selected arguments (Options/Args/Folders)'
    echo \n
    echo "__________________________________________________________"
    echo "Backup Configuration:"
    echo "  Mode: $mode"
    echo "  Source Directory: $from_folder_local"
    echo "  Destination: $to_folder_cloud"
    echo "  Number of Transfers: $transfers"
    echo "  Number of Retries: $retries"
    echo "  Drive Chunk Size: $drive_chunk_size"
    if set -q _flag_fast_list || test $fast_list = true
        echo "  Fast List: Enabled"
    end
    if set -q _flag_follow_symlinks || test $follow_symlinks = true
        echo "  Follow Symlinks: Enabled"
    end
    if set -q _flag_progress || test $progress = true
        echo "  Progress: Enabled"
    end
    if set -q _flag_progress_terminal_title || test $progress_terminal_title = true
        echo "  Progress Terminal Title: Enabled"
    end
    if set -q _flag_dry
        echo "  Dry Run: Enabled"
    end
    if set -q _flag_quiet
        echo "  Quiet Mode: Enabled"
    end
    if set -q _flag_delete_excluded
      echo "  Delete excluded in Remote: Enabled"
    end
    echo "  Exclude From: $exclude_file"
    echo "  Log File: $log_file"
    echo "__________________________________________________________"
    echo \n
  end


  # Argument Evaluation
  # Help
  if set -q _flag_help
    clear
    echo "Usage: bkp [OPTIONS]"
    echo ""
    echo "Backup utility script using rclone. By default, it backs up the '~/.config/' directory."
    echo ""
    echo "Options:"
    echo "  -h, --help                   Display this help message and exit."\n
    echo "  -m, --mode=MODE              Set the rclone mode, default is 'sync'."
    echo "  --from=SOURCE                Specify the source directory for backup, default is '/home/juuls/.config/'."
    echo "  --to=DESTINATION             Specify the rclone destination, default is 'bkp-xps15:/bkp-xps15/.config/'."
    echo "  --delete-excluded            Delete files from exclude_file in remote. Defaults to off"\n
    echo "  -t, --transfers=NUMBER       Set the number of file transfers, default is 20."
    echo "  -r, --retries=NUMBER         Set the number of retries on failure, default is 5."
    echo "  --drive-chunk-size=SIZE      Specify the drive chunk size, default is '1024M'."
    echo "  --fast-list                  Use fast list mode."\n
    echo "  --follow-symlinks            Follow symlinks during backup."\n
    echo "  -p, --progress               Show progress during transfer."
    echo "  --progress-terminal-title    Set the terminal title to the progress."\n
    echo "  -e, --exclude-from=FILE      Exclude files/folders listed in the specified file."
    echo "  --log=DIR                    Log output to the specified directory. File will be timestamped in the title and ends with .log"
    echo "  --force                      Force process without confirmation. (Good for automation)"\n
    echo "  -q, --quiet                  Completely supress output (including errors) to the commandline"
    return
  end
  
  # Mode
  if set -q _flag_mode
    set -l valid_params "sync" "copy"
    
    if contains $_flag_mode $valid_params
      set mode $_flag_mode
    else
      set -l print_error_text "Invalid mode "$_flag_mode
      set -l notify_text "Invalid mode "$_flag_mode
      _print_error
      _notify
      # set -e print_error_text notify_text
      return 1
    end
  end
  
  # Folder to backup
  if set -q _flag_from
    if test -z $_flag_from
      set -l print_error_text "No path given"
      set -l notify_text "No path given"
      _notify
      _print_error
    
      return 1
    end
    if not test -e $_flag_from
      set -l print_error_text "Invalid folder "$_flag_from" does not exist."
      set -l notify_text "Invalid folder "$_flag_from" does not exist."
      _notify
      _print_error
      
      return 1
    end
    
    set -l last_char (string sub -s -1 $_flag_from)
    if not test $last_char = '/'
      set from_folder_local $_flag_from"/"
    else
      set from_folder_local $_flag_from
    end
  end
  
  # Folder to sync/copy to
  if set -q _flag_to
    if test -z $_flag_to
      set -l print_error_text "No path given"
      set -l notify_text "No path given"
      _notify
      _print_error
    
      return 1
    end
    #TODO: Add logic to check if remote path is valid (could be sketchy)
    
    set -l last_char (string sub -s -1 $_flag_to)
    if not test $last_char = '/'
      set to_folder_cloud $_flag_to"/"
    else
      set to_folder_cloud $_flag_to
    end
  end
   
  # Transfer settings
  if set -q _flag_transfers
    if not string match -qr '^-?[0-9]+(\.?[0-9]*)?$' -- "$_flag_transfers"
      set -l print_error_text "$_flag_transfers is not a number"
      set -l notify_text "$_flag_transfers is not a number"
      _notify
      _print_error
      return 1
    end
    if test $_flag_transfers -gt $max_transfers || test $_flag_transfers -eq 0
      set -l print_error_text "Amount of parallel transfers may not be 0 or exceed $max_transfers"
      set -l notify_text "Amount of parallel transfers may not be 0 or exceed $max_transfers"
      _notify
      _print_error
      return 1
    end
    set transfers $_flag_transfers
  end
  
  if set -q _flag_retries
    if not string match -qr '^-?[0-9]+(\.?[0-9]*)?$' -- "$_flag_retries"
      set -l print_error_text "$_flag_retries is not a number"
      set -l notify_text "$_flag_retries is not a number"
      _notify
      _print_error
      return 1
    end
    if test $_flag_retries -gt $max_retries || test $_flag_retries -eq 0
      set -l print_error_text "Amount of retries may not be 0 or exceed $max_retries"
      set -l notify_text "Amount of retries may not be 0 or exceed $max_retries"
      _notify
      _print_error
      return 1
    end
    set retries $_flag_retries
  end
  
  if set -q _flag_drive_chunk_size
    if not is_power_of_two $_flag_drive_chunk_size
      set -l print_error_text "$_flag_drive_chunk_size is not a valid size"
      set -l notify_text "$_flag_drive_chunk_size is not a valid size"
      _notify
      _print_error
      return 1
    end
    # If 'M' is missing at end of given size, append it
    if not string match -qr '^[0-9]{3,4}M$' -- $_flag_drive_chunk_size
      set drive_chunk_size $_flag_drive_chunk_size'M'
    else
      set drive_chunk_size $_flag_drive_chunk_size
    end
  end
  
  # Other
  if set -q _flag_exclude_from
    if test -z $_flag_exclude_from
      set -l print_error_text "No path given"
      set -l notify_text "No path given"
      _notify
      _print_error

      return 1
    end
    if not test -e $_flag_exclude_from
      set -l print_error_text "Invalid file "$_flag_exclude_from" does not exist."
      set -l notify_text "Invalid file "$_flag_exclude_from" does not exist."
      _notify
      _print_error
      
      return 1
    end
    set exclude_file $_flag_exclude_from
  end

  if set -q _flag_log
    # Log path given
    # Append '/' if not in path
    set -l last_char (string sub -s -1 $_flag_log)
    if not test $last_char = '/'
      set log_path $_flag_log"/"
    else
      set log_path $_flag_log
    end

    
    
    set log_path $log_path$log_folder
    if not test -e $log_path
      #TODO: Add safely creating custom log dir
      # set -l notify_text "Log directory not found." # Creating $log_path"
      # set -l print_error_text "Log directory not found." # Creating $log_path"
      # _notify
      # _print_error
      # return 1

      mkdir -p $log_path
    end
    set log_file $log_path"rclone_"$mode"_"$log_file
  else
    # Log path not given
    # Save logs in $from_folder_local/logs
    set -l last_char (string sub -s -1 $from_folder_local)
    if not test $last_char = '/'
      set log_path $from_folder_local"/"
    else
      set log_path $from_folder_local
    end
    
    set log_path $log_path$log_folder
    if not test -e $log_path
      set -l notify_text "Log directory not found. Creating $log_path"
      set -l print_error_text "Log directory not found. Creating $log_path"
      _notify
      _print_error

      if set -q _flag_force
          _create_log_dir
          if test $status -ne 0
            set -l notify_text "Failed to create directory $log_path. Exiting"
            set -l print_error_text "Failed to create directory $log_path. Exiting"
            _notify
            _print_error
            return 1
          else
            echo "Created log directory $log_path" \n
          end
      else
        echo "Create folder $log_path? (Y/N)"
        read -l user_confirm_dir
        switch $user_confirm_dir
          case 'Y' 'y'
            _create_log_dir
            if test $status -ne 0
              set -l notify_text "Failed to create directory $log_path. Exiting"
              set -l print_error_text "Failed to create directory $log_path. Exiting"
              _notify
              _print_error
              return 1
            else
              echo "Created log directory $log_path" \n
            end
          case '*'
            echo "Action cancelled by user" \n
            return 1
        end
      end
    end
    set log_file $log_path"rclone_"$mode"_"$log_file
  end
   

  # Command Building
  set rclone_cmd "rclone \
                  $mode \
                  \"$from_folder_local\" \
                  \"$to_folder_cloud\" \
                  --drive-chunk-size $drive_chunk_size \
                  --transfers $transfers \
                  --retries $retries"
  # Remove spaces
  set rclone_cmd (string replace -ra ' +' ' ' -- $rclone_cmd)

  
  # Append option arguments
  ## fast-list
  if set -q _flag_fast_list || test $fast_list = true
    set rclone_cmd "$rclone_cmd --fast-list"
  end
  
  ## follow-symlinks
  if set -q _flag_follow_symlinks || test $follow_symlinks = true
    set rclone_cmd "$rclone_cmd --copy-links"
  end
  
  ## progress
  if set -q _flag_progress || test $progress = true
    set rclone_cmd "$rclone_cmd --progress"
  end
  
  ## progress-terminal-title
  if set -q _flag_progress_terminal_title || test $progress_terminal_title = true
    set rclone_cmd "$rclone_cmd --progress-terminal-title"
  end
  
  ## dry run
  if set -q _flag_dry
    set rclone_cmd "$rclone_cmd --dry-run"
  end
  
  ## delete excluded
  if set -q _flag_delete_excluded
    set rclone_cmd "$rclone_cmd --delete-excluded"
  end
  
  ## exclude-from
  set rclone_cmd "$rclone_cmd --exclude-from \"$exclude_file\""
  
  ## log
  set rclone_cmd "$rclone_cmd --log-file \"$log_file\""
  
  

  # Show configuration to user
  if not set -q _flag_quiet
    _list_cmd_arguments
  end
  
  # User Confirmation
  if not set -q _flag_force
    echo "Please confirm your configuration to start the backup progress (type 'Yes' to confirm)"
    read -l user_confirm_exec
    switch $user_confirm_exec
      case 'Yes'
        clear
        echo 'Starting Backup in'
        for i in (seq 3 -1 1)
          echo $i
          sleep 1
        end
      case '*'
        echo 'Backup cancelled by user'
        return
    end
  end
  
  
  # Execution
  if set -q _flag_quiet
    eval $rclone_cmd 2&>/dev/null
  else
    # echo $rclone_cmd \n
    eval $rclone_cmd
  end
  
end
