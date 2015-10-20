(mjhoy/require-package 'haskell-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(defun mjhoy/define-haskell-keys ()
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(defun mjhoy/define-haskell-cabal-keys ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-mode-hook 'mjhoy/define-haskell-keys)
(add-hook 'haskell-cabal-hook 'mjhoy/define-haskell-cabal-keys)

;; TODO: Figure out a better way of starting up a haskell process with
;; a custom (helpful default) environment when there is no `shell.nix'
;; present.

;; To use when there is a `shell.nix' in the current directory
(defun mjhoy/set-haskell-program-clean-nix-shell ()
  (interactive)
  (setq haskell-program-name
        "nix-shell --command 'ghci'")
  (message haskell-program-name))

;; To use without a `shell.nix' in the current directory
(defun mjhoy/set-haskell-program-custom-nix-shell ()
  (interactive)
  (setq haskell-program-name
        "nix-shell \
          -p \"haskellPackages.ghcWithPackages (pkgs: with pkgs; [QuickCheck])\" \
          --command 'ghci'")
  (message haskell-program-name))

(mjhoy/set-haskell-program-clean-nix-shell)

;; the following setting will set up haskell-mode to compile with nix-shell:
;; (setq haskell-compile-cabal-build-command
;;       "cd %s && nix-shell --command 'cabal build --ghc-option=-ferror-spans' shell.nix")

(provide 'init-haskell)
