[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/58ace00febb5ba29aba23b6c70afa58ad5da9edb.tar.gz;
  }))
]
