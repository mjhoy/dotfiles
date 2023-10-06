[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/54087a1b3a7ef51d0968bbfa7a700d2848ffae9c.tar.gz;
  }))
]
