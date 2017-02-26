#!/bin/bash

local path="$1"
local passfile="$PREFIX/$path.gpg"
check_sneaky_paths "$path"

if [[ -f $passfile ]]; then
    $GPG -d "${GPG_OPTS[@]}" "$passfile" | tail -n +2 || exit $?
elif [[ -z $path ]]; then
    die ""
else
    die "Error: $path is not in the password store."
fi
