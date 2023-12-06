[
  (import (builtins.fetchTarball {
    # To update:
    # Go to https://github.com/nix-community/emacs-overlay, and grab a commit hash.
    # Swap it in below.
    url = https://github.com/nix-community/emacs-overlay/archive/14bfb2ab205d5040420b4daf90a69f9e169fdb2a.tar.gz;
  }))
]
