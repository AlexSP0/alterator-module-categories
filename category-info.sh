#!/bin/sh

[ $# -ne 1 ] && echo "Usage: $0 <category-name>" && exit 1

old_categories_dir="/usr/share/alterator/desktop-directories"
new_categories_dir="/usr/share/alterator/categories"
category=$1

file=$(grep -l -s -e "Name\s*=\s*$category" $new_categories_dir/*.alterator |
	xargs grep -i -l -s -e "Type\s*=\s*Category")

[ ! -z $file ] && cat "$file" && exit 0

file=$(grep -e "\[X-Alterator Category $category\]" \
	-e "X-Alterator-Category\s*=\s*$category" \
	-l $old_categories_dir/*)

[ -z $file ] && exit 1

content=$(cat $file)
new_body=$(echo "$content" |
	tail -n +2 |
	sed "/\s*X-Alterator-Category\s*=.*/d")

output="[Alterator Entry]"
output=$(echo -e "$output\n$new_body")
output=$(echo -e "$output" | sed "s/\(\s*Type\s*=\s*\).*/\1Category/i")

echo "$output"
