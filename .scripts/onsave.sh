#!/bin/bash

## onsave
#
# onsave triggers actions when there are changes to a specified file or directroy.
#
# Usage
# onsave "<command>" "path/to/watch"
#
# Example:
# onsave 'npm build' ./src
#
# Dependencies:
# Depends on [fd](https://github.com/sharkdp/fd), but could be replaced with `ls` or `find`.

command=$1
watch_path=$2

function _hash() {
	file=$1
	# md5 $file | cut -d "=" -f2 | xargs
	shasum $file | cut -f1 | xargs
}

function _files() {
	fd -d 1 -t f $1
}

hasChanged=false
map=$(mktemp -d)

# Initialize `map` current state
for file in $(_files $watch_path) ; do _hash $file > $map/$file ; done

while true ; do
	for file in $(_files $watch_path) ; do
		new_hash=$(_hash $file)
		old_hash=$(< $map/$file)

		if [[ $new_hash != $old_hash ]] ; then
			hasChanged=true
			echo $new_hash > $map/$file
		fi
	done

	if [[ "${hasChanged}" == "true" ]] ; then
		eval $command
		hasChanged=false
	fi
	sleep .5
done

