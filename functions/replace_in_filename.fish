function replace_in_filename --description 'replaces chars in filenames'
set -f search_char $argv[1]
set -f replace_char $argv[2]
set -f dir $argv[3]

if test (count $argv) -ne 3
echo "Usage: replace_in_filename <search_char> <replace_char> <dir>"
return 1
end

for file in (find $dir -depth -name "*$search_char*")
set -f newname (string replace "$search_char" "$replace_char" "$file")
command mv -n "$file" "$newname"
echo "Renamed '$file' to '$newname'"
end
end
