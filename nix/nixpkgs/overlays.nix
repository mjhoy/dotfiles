[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/695ffac192b54dd9705d07a0c9214f6016619e9a.tar.gz;
  }))
]
