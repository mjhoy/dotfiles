# -*- mode: sh -*-

# Load the environment used by login shells.
source ~/.zprofile

# macOS supplies an SSH agent through the login session.
if [[ "$OSTYPE" != darwin* ]]; then
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

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Intel brew
alias ibrew='arch -x86_64 /usr/local/bin/brew'

# switch to fish!
if command -v fish > /dev/null 2>&1; then                # check that fish is available
    if [[ $(ps -o command= -p $PPID) != "fish" ]]; then  # running `zsh` from within fish works
        exec fish
    fi
else
    echo "(tried to start fish shell; not found)"
fi
