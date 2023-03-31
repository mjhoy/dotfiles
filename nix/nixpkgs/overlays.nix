[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/702b1724ead7b6eec28bfc5e1404c26a57a3b248.tar.gz;
  }))
]
