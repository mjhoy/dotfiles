# -*- mode: sh -*-

source "$HOME/.dotfiles/shell/env.zsh"

typeset -U PATH path # path entries are unique
source "$HOME/.dotfiles/shell/path.zsh"
export PATH

if command -v go > /dev/null 2>&1; then
    export GOPATH="$(go env GOPATH)"
    path+=("$GOPATH/bin")
fi

if command -v java > /dev/null 2>&1; then
    export JAVA_HOME="$(dirname "$(dirname "$(realpath "$(command -v java)")")")"
fi
