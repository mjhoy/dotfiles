[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/f5c2366c5d8f241b8c66e4b18be8ad25ffdb4e48.tar.gz;
  }))
]
