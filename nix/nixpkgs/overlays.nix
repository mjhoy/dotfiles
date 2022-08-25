[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/5cf9609f0bb8567f2f5c951fcd31b62a2f0302f5.tar.gz;
  }))
]
