function ls --description 'Overrides ls to use exa instead' -w eza
	eza -l --color auto --group-directories-first --icons $argv
end
