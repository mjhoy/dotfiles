[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/3750376a60b55eb5f2b62d7e89b34cde0c4f048e.tar.gz;
  }))
]
