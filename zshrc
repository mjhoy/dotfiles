# -*- mode: sh -*-

# path setup
typeset -U PATH path # path entries are unique
path=(
  "$HOME/.nix-profile/bin"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.cabal/bin"
  "$HOME/.ghcup/bin"
  "$HOME/.rbenv/shims"
  "$HOME/.rbenv/bin"
  "$HOME/.yarn/bin"
  "$HOME/bin"
  "$HOME/Library/Application Support/Coursier/bin"
  "/opt/homebrew/bin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "/usr/local/mysql/bin"
  "$path[@]"
)
export PATH

# ssh agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initializing new SSH agent..."
  /usr/bin/env ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  /usr/bin/env ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  #ps ${SSH_AGENT_PID} doesn't work under cywgin
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
  start_agent;
}
else
  start_agent;
fi

# include Postgres.app in path if it exists.
if [ -d /Applications/Postgres.app/Contents/Versions/9.6/bin ]; then
  export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin
fi

# include VSCode binaries in path if it exists
if [ -d /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin ]; then
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# nix
. ~/.dotfiles/bash/nix

# source "bash_local" if it exists
if [ -f ~/.bash_local ]; then
   . ~/.bash_local
fi

function seecert () {
  nslookup $1
  (openssl s_client -showcerts -servername $1 -connect $1:443 <<< "Q" | openssl x509 -text)
}

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# ghcup
[ -f "~/.ghcup/env" ] && source "~/.ghcup/env"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Go
if command -v go &> /dev/null; then
    export GOPATH="$(go env GOPATH)"
    export PATH="${PATH}:${GOPATH}/bin"
fi

# Intel brew
alias ibrew='arch -x86_64 /usr/local/bin/brew'

# my ledger file
export LEDGER_FILE="$HOME/proj/bookkeeping/2023.dat"

# kinda hacky; backfill JAVA_HOME from nix-installed java path
if whence -p java &> /dev/null
then
    export JAVA_HOME=$(readlink -f $(dirname $(readlink $(whence java)))/../)
fi
