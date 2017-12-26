#!/bin/bash

local path="$1"
local key="$2"
local passfile="$PREFIX/$path.gpg"
check_sneaky_paths "$path"

if [[ -f $passfile ]]; then
    $GPG -d "${GPG_OPTS[@]}" "$passfile" \
        | tail -n +2 \
        | grep "^$key:" \
        | cut -d: -f2 \
        | sed -e 's/^[ \t]*//' \
        || exit $?
elif [[ -z $path ]]; then
    die ""
else
    die "Error: $path is not in the password store."
fi
