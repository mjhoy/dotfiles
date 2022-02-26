[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/9a35488970b3f33a6df6a0d9387a0c8c4c555c1d.tar.gz;
  }))
]
