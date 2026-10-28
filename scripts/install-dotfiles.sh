#!/usr/bin/env bash
#
# Install dotfiles to the user's HOME by symbolically linking them.

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

dotfiles=( gemrc
           gitconfig
           vim/vimrc
           vim
           bashrc
           ghci
           tmux.conf
           emacs.d
           offlineimaprc
           offlineimap.py
           psqlrc
           eslintrc
           zprofile
           zshrc
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

mkdir -p "$HOME/.config/nix"
lns "$(pwd)/nix/nix.conf" "$HOME/.config/nix/nix.conf"

mkdir -p "$HOME/.config/fish"
lns "$(pwd)/fish/config.fish" "$HOME/.config/fish/config.fish"

mkdir -p "$HOME/.claude/skills"
lns "$(pwd)/agents/instructions.md" "$HOME/.claude/CLAUDE.md"
lns "$(pwd)/agents/claude/settings.json" "$HOME/.claude/settings.json"
lns "$(pwd)/agents/claude/statusline.sh" "$HOME/.claude/statusline.sh"
for i in agents/skills/* ; do
    skill=${i##*/}
    lns "$(pwd)/$i" "$HOME/.claude/skills/$skill"
done

# Add a ApplicationSupport directory without a space for mac os.
if [[ -e "$HOME/Library/Application Support" ]]; then
    lns "$HOME/Library/Application Support" "$HOME/Library/ApplicationSupport"
fi

OS=`uname`

if [[ "${OS}" == "Darwin" ]]; then
    if [[ -d "$HOME/Library/ApplicationSupport/Code/User" ]]; then
        lns "$(pwd)/vscode/settings.json" "$HOME/Library/ApplicationSupport/Code/User/settings.json"
    else
        echo "No VS Code application support folder; skipping settings.json."
    fi
fi
