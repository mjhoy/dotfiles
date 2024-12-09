set -g fish_greeting

# Truncate long git branch names in the prompt
set -g __fish_git_prompt_shorten_branch_len 20

if status is-interactive
    # Commands to run in interactive sessions can go here
end
