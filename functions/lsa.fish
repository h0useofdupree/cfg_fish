function lsa --description 'Overrides ls to use exa with -a attribute'
  eza -l --color auto --group-directories-first --icons -a $argv
end
