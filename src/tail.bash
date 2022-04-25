#!/usr/bin/env bash

clip=0
opts="$($GETOPT -o c -l clip -n "$PROGRAM" -- "$@")"
err=$?
eval set -- "$opts"
while true; do case $1 in 
	-c|--clip) clip=1; shift ;;
	--) shift; break  ;;
esac done

[[ $err -ne 0 || $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND [--clip,-c] [pass-name]"

path=$1
passfile="$PREFIX/$path.gpg"
check_sneaky_paths "$path"

if [[ -f $passfile ]]; then
	if [[ $clip -eq 1 ]]; then
		pass="$($GPG -d "${GPG_OPTS[@]}" "$passfile" | $BASE64)" || exit $?
		echo "$pass" | $BASE64 -d | tail -n +2 
		cpy="$(echo "$pass" | $BASE64 -d | head -n 1 | $BASE64)"
		clip "$(echo "$cpy" | $BASE64 -d)" "$path"
	else
		$GPG -d "${GPG_OPTS[@]}" "$passfile" | tail -n +2 || exit $?
	fi
elif [[ -d $PREFIX/$path ]]; then
	if [[ -z $path ]]; then
		echo "Password Store"
	else
		echo "${path%\/}"
	fi
	tree -N -C -l --noreport "$PREFIX/$path" 3>&- | tail -n +2 | sed -E 's/\.gpg(\x1B\[[0-9]+m)?( ->|$)/\1\2/g' # remove .gpg at end of line, but keep colors
elif [[ -z $path ]]; then
	die "Error: password store is empty. Try \"pass init\"."
else
	die "Error: $path is not in the password store."
fi
