[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/08dd5fc2b327774d7b605a39273b23af7d4af08f.tar.gz;
  }))
]
