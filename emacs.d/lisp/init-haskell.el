(mjhoy/require-package 'haskell-mode)
(mjhoy/require-package 'ghc)
(mjhoy/require-package 'company-ghc)

(require 'init-company)
(require 'company) ; to reference 'company-backends below

(defun mjhoy/haskell-cabal-setup ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-cabal-hook 'mjhoy/haskell-cabal-setup)

(defun mjhoy/ghc-type-info-as-comment ()
  "Using ghc-mod, get the type info at point and insert it as a comment.

See also `ghc-show-type'.
"
  (interactive)

  ;; taken from the `ghc-show-type' source.
  (let ((tinfos (ghc-type-get-tinfos)))
    (if (null tinfos)
        (progn
          (ghc-type-clear-overlay)
          (message "Cannot determine type"))
      (let* ((tinfos (ghc-type-get-tinfos))
             (tinfo (nth (ghc-type-get-ix) tinfos))
             (type (ghc-tinfo-get-info tinfo)))
        (previous-line)
        (move-end-of-line nil)
        (newline)
        (comment-indent)
        (insert type)
        (ghc-type-clear-overlay)
        ))))

(defun mjhoy/haskell-mode-setup ()
  "My custom setup for Haskell mode."

  ;; define haskell mode keys
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile)
  (define-key haskell-mode-map (kbd "C-c C-z") 'switch-to-haskell)
  (define-key haskell-mode-map (kbd "C-c C-l") 'inferior-haskell-load-file)
  (define-key haskell-mode-map (kbd "C-h C-d") 'inferior-haskell-find-haddock)
  (define-key haskell-mode-map (kbd "C-c M-t") 'mjhoy/ghc-type-info-as-comment)

  ;; indentation
  (turn-on-haskell-indentation)

  ;; Do we need this?
  (ghc-type-init)
  )

(add-hook 'haskell-mode-hook 'mjhoy/haskell-mode-setup)

;; ghc-mod setup
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-type-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

;; ghc-mod company
(add-to-list 'company-backends 'company-ghc)

;; use web-mode for snap heist templates
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))

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
