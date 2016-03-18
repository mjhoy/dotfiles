(mjhoy/require-package 'haskell-mode)
(mjhoy/require-package 'ghc)
(mjhoy/require-package 'company-ghc)

(require 'init-company)
(require 'company) ; to reference 'company-backends below

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(defun mjhoy/define-haskell-keys ()
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
  (define-key haskell-mode-map (kbd "C-c C-z") 'switch-to-haskell)
  (define-key haskell-mode-map (kbd "C-c C-l") 'inferior-haskell-load-file)
  )
(defun mjhoy/define-haskell-cabal-keys ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-mode-hook 'mjhoy/define-haskell-keys)
(add-hook 'haskell-cabal-hook 'mjhoy/define-haskell-cabal-keys)

;; ghc-mod setup
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
;;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; ghc-mod company
;;(add-to-list 'company-backends 'company-ghc)

;; use web-mode for snap heist templates
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))

;; TODO: Figure out a better way of starting up a haskell process with
;; a custom (helpful default) environment when there is no `shell.nix'
;; present.

;; run with my default haskell environment
;; (see: myHaskellEnv in nix/mjhoy/config.nix)
(defun mjhoy/set-haskell-program-default-shell ()
  (interactive)
  (setq haskell-program-name "ghci")
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
