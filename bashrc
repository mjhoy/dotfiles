. ~/.dotfiles/bash/env
. ~/.dotfiles/bash/config
. ~/.dotfiles/bash/aliases

# rbenv, if present
if hash rbenv 2>/dev/null; then
    eval "$(rbenv init -)"
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
