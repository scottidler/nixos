#!/usr/bin/env bash

if [ -n "$DEBUG" ]; then
	PS4=':${LINENO}+'
	set -x
fi

linker() {
	file=$(realpath "$1")
	link="${1/HOME/$HOME}"
	echo "$link -> $file"
	if [ -f "$link" ] && [ "$file" != "$(readlink $link)" ]; then
		orig="$link.orig"
		$DEBUG && echo "backing up $orig"
		mv $link $orig
	elif [ ! -f "$link" ] && [ -L "$link" ]; then
		$DEBUG && echo "removing broken link $link"
		unlink $link
	fi
	if [ -f "$link" ]; then
		echo "[exists] $link"
	else
		echo "[create] $link -> $file"
		mkdir -p $(dirname $link)
		ln -s $file $link
	fi
}

SCRIPT_PATH=$(dirname $(realpath -s $0))
pushd $SCRIPT_PATH
find "HOME" -type f | while read -r file; do
	linker2 $file
done
popd
