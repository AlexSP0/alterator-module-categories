#!/bin/sh

[ $# -ne 1 ] && echo "Usage: $0 <category-name>" && exit 1

old_categories_dir="/usr/share/alterator/desktop-directories"
new_categories_dir="/usr/share/alterator/categories"
category=$1

file=`grep -l -s -e "\[Alterator $category\]" $new_categories_dir/* \
          | xargs -0 grep -i -l -s -e "Type\s*=\s*Category"`

[ ! -z $file ] && cat "$file" && exit 0

file=`grep -e "\[X-Alterator Category $category\]" \
           -e "X-Alterator-Category\s*=\s*$category" \
           -l $old_categories_dir/*`

[ -z $file ] && exit 1

content=`cat $file`
desktop_entry_body=`echo "$content" | tail -n +2`
desktop_name=`echo "$content" \
                  | grep -i "\s*Name\s*=" \
                  | head -n 1 \
                  | cut -d "=" -f 2 \
                  | xargs`

output="[Alterator Entry]"
output=`echo -e "$output\nObjects=$desktop_name"`
output=`echo -e "$output\n\n[Alterator $desktop_name]"`
output=`echo -e "$output\n$desktop_entry_body"`
output=`echo -e "$output" | sed "s/\(\s*Type\s*=\s*\).*/\1$new_type/i"`

echo "$output"
