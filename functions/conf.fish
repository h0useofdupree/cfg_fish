function conf --description 'Configuration management tool'
  argparse 'h/help' 'V/version' 'v/verbose' -- $argv
  or return

  if set -q _flag_help
    echo "Help"
  end

  
end
