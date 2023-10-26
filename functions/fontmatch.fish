function fontmatch --description 'fc-match but smarter'
clear
fc-match -a | grep -i "$argv"
end
