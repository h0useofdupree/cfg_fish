function lsa --description 'Overrides ls to use exa with -a attribute'
exa -l --color auto --group-directories-first --icons -a $argv
end
