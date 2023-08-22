[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/07500c2529eb8af81b1b26d82e3c3704520d8ffd.tar.gz;
  }))
]
