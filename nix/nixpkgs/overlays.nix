[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/95fee6e5b164a4c0f1e33d9fe30bb717fc74a66c.tar.gz;
  }))
]
