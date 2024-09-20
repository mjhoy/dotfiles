[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/1ac2a8f8ba9d1cbe621d1890dce295716d603daf.tar.gz;
  }))
]
