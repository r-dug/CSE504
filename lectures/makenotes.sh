#!/bin/bash
function join_by {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

while getopts f:F: flag
do 
    case "${flag}" in
        f) file=${OPTARG};;
        F) opt_file=${OPTARG};;
    esac
done


if [ "$opt_file" != "" ];then
text="";
echo "reading input file"
while IFS= read -r line || [[ -n "$line" ]]; do
  text="$text$line"
done < "$opt_file"
fi
if [ -z $text ];then
text="
## Title

-
-
-
-

## Notes"
fi

current_date=$(date +"%d_%m_%Y")
filename="$file-$current_date.md"
echo "" > "$filename"
echo "# $filename

## $current_date
$text" > "$filename"
echo "$filename written as:"
echo < "$(<$filename )"