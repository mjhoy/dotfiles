[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/1ff5471880b6e48f63ec5fa668486ab1268c2b22.tar.gz;
  }))
]
