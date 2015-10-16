(mjhoy/require-package 'haskell-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(defun mjhoy/define-haskell-keys ()
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(defun mjhoy/define-haskell-cabal-keys ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-mode-hook 'mjhoy/define-haskell-keys)
(add-hook 'haskell-cabal-hook 'mjhoy/define-haskell-cabal-keys)

;; use ghci through nix
(setq haskell-program-name "nix-shell -p haskellPackages.ghc --command 'ghci'")

;; the following setting will set up haskell-mode to compile with nix-shell:
;; (setq haskell-compile-cabal-build-command
;;       "cd %s && nix-shell --command 'cabal build --ghc-option=-ferror-spans' shell.nix")

(provide 'init-haskell)
