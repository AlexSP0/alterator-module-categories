#!/bin/sh

get_ini_field() {
    echo "$input" \
        | grep -i "\s*$1\s*=" \
        | head -n 1 \
        | cut -d "=" -f 2 \
        | xargs
}

if [ $# -ne 0 ]; then
    echo "Usage: $0 < input_file.desktop"
    exit 1
fi

# Read all stdin into variable
input=`cat`

desktop_entry_body=`echo "$input" | tail -n +2`
desktop_name=`get_ini_field "Name"`

output="[Alterator Entry]"
output=`echo -e "$output\nObjects=$desktop_name"`
output=`echo -e "$output\n\n[Alterator $desktop_name]"`
output=`echo -e "$output\n$desktop_entry_body"`
output=`echo -e "$output" | sed "s/\(\s*Type\s*=\s*\).*/\1$new_type/i"`

echo "$output"
