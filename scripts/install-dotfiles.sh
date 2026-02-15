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

if [[ ! -e $HOME/.config/nix ]]; then
    mkdir -p $HOME/.config/nix
fi

if [[ ! -e $HOME/.config/nix/nix.conf ]]; then
    lns $(pwd)/nix/nix.conf $HOME/.config/nix/nix.conf
fi

if [[ ! -e $HOME/.config/fish ]]; then
    mkdir -p $HOME/.config/fish
fi

if [[ ! -e $HOME/.config/fish/config.fish ]]; then
    lns $(pwd)/fish/config.fish $HOME/.config/fish/config.fish
fi

# Add a ApplicationSupport directory without a space for mac os.
if [[ -e $HOME/Library/Application\ Support && ! -e $HOME/Library/ApplicationSupport ]]; then
    ln -s $HOME/Library/Application\ Support $HOME/Library/ApplicationSupport
fi

OS=`uname`

if [[ "${OS}" == "Darwin" ]]; then
    if [[ -d "$HOME/Library/ApplicationSupport/Code/User" ]]; then
        if [[ ! -e "$HOME/Library/ApplicationSupport/Code/User/settings.json" ]]; then
            lns $(pwd)/vscode/settings.json $HOME/Library/ApplicationSupport/Code/User/settings.json
        fi
    else
        echo "No VS Code application support folder; skipping settings.json."
    fi
fi
