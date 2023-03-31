[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/d163289df28f2a7e3169fda7a6d3e2ec53980c84.tar.gz;
  }))
]
