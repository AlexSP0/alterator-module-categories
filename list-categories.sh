#!/bin/sh

old_categories_dir="/usr/share/alterator/desktop-directories"
new_categories_dir="/usr/share/alterator/objects"

sed -n -e "s/X-Alterator-Category\s*=\(.*\)/\1/p" $old_categories_dir/*


grep -s -l -e "\[Alterator Entry\]" $new_categories_dir/*.alterator |
    xargs grep -l -e "Type\s*=\s*Category" |
    xargs sed -n -e "s/Name\s*=\s*\(.*\)/\1/p"