# -*- mode: sh -*-

export PNPM_HOME="$HOME/Library/pnpm"

# Environment shared by interactive and non-interactive login shells.
typeset -U PATH path # path entries are unique
path=(
  "$HOME/.nix-profile/bin"
  "$HOME/.local/bin"
  "$HOME/.docker/bin"
  "$HOME/.cargo/bin"
  "$HOME/.cabal/bin"
  "$HOME/.ghcup/bin"
  "$HOME/.rbenv/shims"
  "$HOME/.rbenv/bin"
  "$HOME/.yarn/bin"
  "$HOME/bin"
  "$HOME/Library/Application Support/Coursier/bin"
  "$PNPM_HOME/bin"
  "/opt/homebrew/bin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "/usr/local/mysql/bin"
  "$path[@]"
)
export PATH
