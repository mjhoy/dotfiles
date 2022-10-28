[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/b3f81bcbda84bf2ef957cfff6cf89aedbdfa2be9.tar.gz;
  }))
]
