[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/99fb18c4f0b7abdcd2d93c98c94e6d3d745ee283.tar.gz;
  }))
]
