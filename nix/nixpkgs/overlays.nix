[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/d7155aaadc98b2c13874f78cc5e00f2dfefd7a6e.tar.gz;
  }))
]
