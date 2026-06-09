# nix (multi-user daemon install)
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

set -g fish_greeting

# Truncate long git branch names in the prompt
set -g __fish_git_prompt_shorten_branch_len 20

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Work-specific stuff goes in ~/.config/fish/work.fish
if test (hostname) = "plumbeous"
    and test -f ~/.config/fish/work.fish
    source ~/.config/fish/work.fish
end

set -gx EDITOR vi
