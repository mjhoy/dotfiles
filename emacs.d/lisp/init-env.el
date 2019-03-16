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


;; nixos:
;;
;; emacs (when launched from the gui/xmonad) does not seem to connect
;; with my ssh-agent, and there may be other issues. i think that
;; perhaps exec-path-from-shell can solve my issues but i haven't
;; figured it out yet.
;;
;; attempt below, doesn't actually fix it.

;; package: 'exec-path-from-shell
;; (exec-path-from-shell-initialize)
;; (exec-path-from-shell-copy-env "INFOPATH")
;; (exec-path-from-shell-copy-env "NIX_PATH")
;; (exec-path-from-shell-copy-env "SSH_AGENT_PID")
;; (exec-path-from-shell-copy-env "SSH_ASKPASS")
;; (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

(provide 'init-env)
