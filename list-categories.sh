#!/bin/sh

old_categories_dir="/usr/share/alterator/desktop-directories"
new_categories_dir="/usr/share/alterator/objects"

find $old_categories_dir -type f -exec \
	sed -e "s/X-Alterator-Category\s*=\(.*\)/\1/p" \;

alterator_files=$(find $new_categories_dir -name "*.alterator")

for file in "$alterator_files"; do
	grep -q -e "^\s*Type\s*=\s*Category" $file &&
		sed -n -e "s/s*Name\s*=\(.*\)/\1/p" $file | xargs
done
