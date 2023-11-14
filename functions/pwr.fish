function pwr --description 'Random wallpaper setter with colors n stuff'

  set -l backend haishoku
  # set -l background '000000'
  set -l WALL "$HOME/Pictures/walls/"(command ls -p ~/Pictures/walls/ | grep -v / | shuf -n1)
  set -l SKIP_WAL false

 # Handle the 'backend' subcommand
  if contains "backend" $argv
    set -l index (contains -i "backend" $argv)
    if test (count $argv) -ge (math $index + 1) # Ensure there's an argument after "backend"
      set backend $argv[(math $index + 1)]
      set -e argv[(math $index + 1)] # Remove backend value
      set -e argv[$index] # Remove "backend"
    end
  end

  argparse 'h/help' 's/skip_wal' 'a/alpha=' 'b/background=' 'w/wallpaper=' 'l/light' -- $argv
  or return

  # Evaluate flags
  if set -q _flag_help
    echo "Usage: pwr [OPTIONS] [SUBCOMMAND]"
    echo ""
    echo "A script to manage wallpapers and color schemes."
    echo ""
    echo "Options:"
    echo "  -h, --help       Display this help message ⓘ"
    echo "  -w, --wallpaper  Set a specific wallpaper path (followed by the path) 🖼"
    echo "  -l, --light      Use light color scheme"
    echo ""
    echo "Subcommands:"
    echo "  backend          🎨 Choose a pywal backend. Available backends include:"
    echo "                     - wal 🌀"
    echo "                     - colorz 🌈"
    echo "                     - colorthief 🔍"
    echo "                     - fast_colorthief ⏩🔍"
    echo "                     - haishoku 🌸"
    echo "                     Use this subcommand last for correct completions."
    echo ""
    echo "Example:"
    echo "  pwr -c -w /path/to/wallpaper.jpg backend haishoku"
    return 0
  end

  if set -q _flag_alpha
    set alpha $_flag_alpha
  end

  if set -q _flag_s
    set SKIP_WAL true
  end

  if set -q _flag_wallpaper
    set WALL $_flag_wallpaper
  end

  if set -q _flag_light
    set scheme "-l"
  end

  # if set -q _flag_background
  #   set background $_flag_background
  # end

    # Generate Palette
  if test $SKIP_WAL = 'true'
    swww img $WALL
  else  
    wal -ni $WALL --backend $backend $background $scheme --cols16
  end
  
  # Wait for Hyprland to restart
  sleep 1.5s
  # Set wallpaper
  swww img $WALL --transition-fps 144 &
end
