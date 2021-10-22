[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/e594a3e8a7d0fbed07a4ed61a7b3eb8f15ece547.tar.gz;
  }))
]
