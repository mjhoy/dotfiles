[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/88dcf53013b1f8f0a6a1766fc76ed181e0a6a8db.tar.gz;
  }))
]
