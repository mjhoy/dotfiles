[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/fe55f8be14c4537f42b037051e9f5cb7ffcad246.tar.gz;
  }))
]
