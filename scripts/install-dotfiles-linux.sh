#!/usr/bin/env bash
#
# Install linux-specific dotfiles (i.e., anything that doesn't apply
# to macOS) to the user's HOME by symbolically linking them.

set -e

function run() {
    echo "$@"
    "$@"
}

function lns() {
    local source="$1" destination="$2"
    if [[ -e "$destination" || -L "$destination" ]]; then
        if [[ ! -L "$destination" || "$(readlink "$destination")" != "$source" ]]; then
            printf 'Warning: %s exists and is not a symlink to %s.\n' "$destination" "$source" >&2
            return 0
        fi
    else
        run ln -s "$source" "$destination"
    fi
    if [[ ! -e "$source" ]]; then
        printf 'Warning: source %s is missing; symlink %s is dangling.\n' "$source" "$destination" >&2
    fi
}

dotfiles=( linux/xmonad
           linux/xmobarrc
           linux/gtkrc-2.0
           linux/Xresources
         )
regex="/?([^/]+)$"
for i in "${dotfiles[@]}" ; do
    [[ $i =~ $regex ]]
    filename=${BASH_REMATCH[1]}
    dotfilename="$HOME/.$filename"
    lns "$(pwd)/$i" "$dotfilename"
done

mkdir -p "$HOME/bin"
for i in bin/* ; do
    lns "$(pwd)/$i" "$HOME/$i"
done

lns "$(pwd)" "$HOME/.dotfiles"
