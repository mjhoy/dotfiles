(require 'init-lsp)
(require 'lsp)
(require 'lsp-haskell)

(require 'w3m-haddock)

(defun mjhoy/haskell-cabal-setup ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-cabal-hook 'mjhoy/haskell-cabal-setup)


(defun mjhoy/haskell-mode-setup ()
  "My custom setup for Haskell mode."

  ;; define haskell mode keys
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
  (define-key haskell-mode-map (kbd "C-c C-z") 'switch-to-haskell)
  (define-key haskell-mode-map (kbd "C-c C-l") 'inferior-haskell-load-file)
  (define-key haskell-mode-map (kbd "C-h C-d") 'inferior-haskell-find-haddock)
  ;; (define-key haskell-mode-map (kbd "C-c M-t") 'mjhoy/ghc-type-info-as-comment)

  ;; indentation
  (turn-on-haskell-indentation)

  (lsp)

  ;; Do we need this?
  ;; (ghc-type-init)
  )

(add-hook 'haskell-mode-hook 'mjhoy/haskell-mode-setup)

;; use web-mode for snap heist templates
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))

(defun mjhoy/set-haskell-program-ghci ()
  "Set my haskell program to just use plain ghci."
  (interactive)
  (setq haskell-program-name "ghci")
  (message haskell-program-name))

;; run with my default haskell environment
;; (see: myHaskellEnv in nix/mjhoy/config.nix)
(defun mjhoy/set-haskell-program-default-shell ()
  (interactive)
  (setq haskell-program-name "cabal new-repl")
  (message haskell-program-name))

;; To use when there is a `shell.nix' in the current directory
(defun mjhoy/set-haskell-program-nix-shell ()
  (interactive)
  (setq haskell-program-name
        "nix-shell --command 'ghci'")
  (message haskell-program-name))

(mjhoy/set-haskell-program-default-shell)

;; the following setting will set up haskell-mode to compile with nix-shell:
;; (setq haskell-compile-cabal-build-command
;;       "cd %s && nix-shell --command 'cabal build --ghc-option=-ferror-spans' shell.nix")

(provide 'init-haskell)
