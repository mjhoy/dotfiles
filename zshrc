# completion init
autoload -Uz compinit
compinit

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
  "$HOME/bin"
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
if [ -f /Applications/Postgres.app/Contents/Versions/9.6/bin/psql ]; then
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin
fi

# nix
. ~/.dotfiles/bash/nix