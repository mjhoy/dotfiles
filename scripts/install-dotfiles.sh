#!/usr/bin/env bash
#
# Install dotfiles to the user's HOME by symbolically linking them.

set -e

function run() {
    echo "$@"
    $($@)
}

function lns() {
    run "ln -s $1 $2"
}

dotfiles=( gemrc
           gitconfig
           vim/vimrc
           vim
           bashrc
           ghci
           tmux.conf
           emacs.d
           nix/nixpkgs
           offlineimaprc
           offlineimap.py
           eslintrc
           zshrc
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

# ad-hoc installs
mkdir -p ~/.config/nixpkgs
lns $(pwd)/nix/nixpkgs/overlays.nix $HOME/.config/nixpkgs/overlays.nix
