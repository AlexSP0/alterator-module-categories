#!/bin/sh

[ $# -ne 1 ] && echo "Usage: $0 <category-name>" && exit 1

old_categories_dir="/usr/share/alterator/desktop-directories"
new_categories_dir="/usr/share/alterator/categories"
category=$1

new_file=`grep -l -s -e "\[Alterator $category\]" $new_categories_dir/* \
              | xargs -0 grep -i -l -s -e "Type\s*=\s*Category"`

[ ! -z $new_file ] && cat "$new_file" && exit 0

old_file=`grep -e "\[X-Alterator Category $category\]" \
               -e "X-Alterator-Category\s*=\s*$category" \
               -l $old_categories_dir/*`

[ ! -z $old_file ] && ./legacy-category-converter.sh < "$old_file"
