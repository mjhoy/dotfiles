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
