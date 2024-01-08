function ze --description '7z extract to dir(filename)'
set -f archive $argv[1]
if test -z "$archive"
echo "Usage: ze <archive.7z>"
return 1
end

if not test -f $archive
echo "File '$archive' does not exist"
return 1
end

set dirname (string split -r "." $archive)[1]
mkdir -p $dirname

7z x $archive -o$dirname/
echo "Extracted '$archive' into '$dirname/'"
end
