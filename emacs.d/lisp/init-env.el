;; make sure that NIX_GHC* env vars are present in the emacs
;; process. this ensures that `ghc-mod' e.g. will run in the correct
;; environment.

(if (file-exists-p "~/.nix-profile/bin/ghc")
    (progn
      (setenv "NIX_GHC" "$HOME/.nix-profile/bin/ghc" t)
      (setenv "NIX_GHCPKG" "$HOME/.nix-profile/bin/ghc-pkg" t)
      (setenv "NIX_GHC_DOCDIR" "$HOME/.nix-profile/share/doc/ghc/html" t)
      (setenv "NIX_GHC_VERSION"
              (replace-regexp-in-string
               "\n$" ""                 ; remove trailing newline from shell output
               (shell-command-to-string "$NIX_GHC --numeric-version")))
      (setenv "NIX_GHC_LIBDIR" "$HOME/.nix-profile/lib/ghc-$NIX_GHC_VERSION" t)))

(provide 'init-env)
