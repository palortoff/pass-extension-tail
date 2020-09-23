#!/usr/bin/env bash

[[ $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND pass-name"

path="${1%/}"

# Get the full content
content=$(cmd_show "$path")
[[ $? -ne 0 ]] && die "$content"

# Get the first line (password)
password=$(echo "$content" | head -n 1)
# Get the rest
rest=$(echo "$content" | tail -n +2)

# Display the rest
echo "$rest"

# Clip password
clip "$password" "$path" >&2

