[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/5c16b4515d956c2db9334ac7f1a7982baca0ba4e.tar.gz;
  }))
]
