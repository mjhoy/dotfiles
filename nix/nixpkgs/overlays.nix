[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/a70fd6e93de6f0d0bca3c02f9cc1acbaa914254e.tar.gz;
  }))
]
