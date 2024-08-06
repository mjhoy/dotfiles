[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/5a51bdfd8dae135ce6ab3e47890900d1d2a44357.tar.gz;
  }))
]
