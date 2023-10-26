function lst --description 'Fish wrapper for exas ls tree with depth of 2'
  eza -lTL 2 --color auto --group-directories-first  --icons $argv
end
