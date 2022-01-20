[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/6dc044d3d10a69d455c9cb1a7698622f6a92a7df.tar.gz;
  }))
]
