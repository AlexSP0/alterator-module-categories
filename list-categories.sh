#!/bin/sh

old_categories_dir="/usr/share/alterator/desktop-directories"
new_categories_dir="/usr/share/alterator/categories"

sed -n -e "s/X-Alterator-Category\s*=\(.*\)/\1/p" $old_categories_dir/*

grep -s -l -e "Type\s*=\s*Category" $new_categories_dir/* \
    | xargs sed -n -e "s/\[Alterator \(.*\)\]/\1/p" \
    | tail -n 1
