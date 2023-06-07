function ls --description 'Overrides ls to use exa instead'
	exa -l --color auto --group-directories-first --icons $argv
end
