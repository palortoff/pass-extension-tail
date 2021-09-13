#!/usr/bin/env bash

[[ $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND pass-name"

path=${1%/}
check_sneaky_paths "$path"
mkdir -p -v "$PREFIX/$(dirname -- "$path")"
set_gpg_recipients "$(dirname -- "$path")"
passfile="$PREFIX/$path.gpg"
set_git "$passfile"

tmpdir #Defines $SECURE_TMPDIR
tmp_file="$(mktemp -u "$SECURE_TMPDIR/XXXXXX")-${path//\//-}.txt"

action="Add"
if [[ -f $passfile ]]; then
    $GPG -d "${GPG_OPTS[@]}" "$passfile" | tail -n +2 > "$tmp_file" || exit 1
    action="Edit"
fi
${EDITOR:-vi} "$tmp_file"
[[ -f $tmp_file ]] || die "New password not saved."
$GPG -d -o - "${GPG_OPTS[@]}" "$passfile" 2>/dev/null | tail -n +2 | diff - "$tmp_file" &>/dev/null && die "Password unchanged."

tmp_file_joined="$(mktemp -u "$SECURE_TMPDIR/XXXXXX")-${path//\//-}.txt"

$GPG -d "${GPG_OPTS[@]}" "$passfile" | head -n 1 > "$tmp_file_joined"
cat "$tmp_file" >> "$tmp_file_joined"

while ! $GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" "$tmp_file_joined"; do
    yesno "GPG encryption failed. Would you like to try again?"
done
git_add_file "$passfile" "$action password for $path using ${EDITOR:-vi}."
