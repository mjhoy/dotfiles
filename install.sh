#!/usr/bin/env bash

set -e

function run() {
    echo "$@"
    $($@)
}

function lns() {
    run "ln -s $1 $2"
}

dotfiles=( gemrc
           screenrc
           gitconfig
           vim/vimrc
           vim
           bashrc
           ghci
           tmux.conf
           mutt_color
           emacs.d
           xmonad
           nix/nixpkgs
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

if [[ ! -e $HOME/.dotfiles ]]; then
    lns $(pwd) $HOME/.dotfiles
fi