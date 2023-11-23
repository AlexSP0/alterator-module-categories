#!/bin/sh

old_categories_dir="/usr/share/alterator/desktop-directories"
new_categories_dir="/usr/share/alterator/categories"

find $old_categories_dir -type f -exec \
	sed -n -e "s/X-Alterator-Category\s*=\(.*\)/\1/p" {} \;

alterator_files=$(test -d $new_categories_dir && find $new_categories_dir -name "*.alterator")

[ -z $alterator_files ] && exit 0

for file in "$alterator_files"; do
	grep -e "^\s*Type\s*=\s*Category" $file &&
		sed -n -e "s/s*Name\s*=\(.*\)/\1/p" $file | xargs
done
