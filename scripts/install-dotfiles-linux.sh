#!/usr/bin/env bash
#
# Install linux-specific dotfiles (i.e., anything that doesn't apply
# to macOS) to the user's HOME by symbolically linking them.

set -e

function run() {
    echo "$@"
    $($@)
}

function lns() {
    run "ln -s $1 $2"
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
    if [[ ! -e $dotfilename ]]; then
        cmd="ln -s $(pwd)/$i $dotfilename"
        run $cmd
    fi
done

mkdir -p $HOME/bin
for i in bin/* ; do
    if [[ ! -e $HOME/$i ]]; then
        cmd="ln -s $(pwd)/$i $HOME/$i"
        run $cmd
    fi
done

if [[ ! -e $HOME/.dotfiles ]]; then
    lns $(pwd) $HOME/.dotfiles
fi
