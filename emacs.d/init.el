;; ❄ emacs setup ❄

(defun mjhoy/load-init-file (path &optional noerror)
  "Load a file from the ~/.emacs.d directory."
  (let ((file (file-name-sans-extension
               (expand-file-name path user-emacs-directory))))
    (load file noerror)))

;; load packages
(mjhoy/load-init-file "mjhoy/packages.el")

(setq user-mail-address "michael.john.hoy@gmail.com")

;; keep backups under ~/.emacs.d
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backups" user-emacs-directory))))


;; interface
;; =========

;; no menu bar
(menu-bar-mode 0)

;; no splash screen
(setq inhibit-splash-screen t)

;; theme: tomorrow night bright
(load-theme 'sanityinc-tomorrow-bright t)


;; ido
;; ===

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)


;; ruby
;; ====

(add-to-list 'auto-mode-alist '("Rakefile\\'"   . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'"    . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))

;; js
;; ==

(setq js-indent-level 2)

;; hippy expand
;; ============

(setq hippie-expand-try-functions-list
      '(try-expand-all-abbrevs
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))


;; org mode
;; ========

(setq org-agenda-files (list "~/org/class.org"
                             "~/org/work.org"
                             "~/org/daily.org"))

;; misc functions
;; ==============

(defun mjhoy/lookup-apple-dictionary ()
  "Open Apple's dictionary app for the current word."
  (interactive)
  (let* ((myWord (thing-at-point 'symbol))
         (myUrl (concat "dict://" myWord)))
    (browse-url myUrl)))

(defun mjhoy/lookup-dash ()
  "Query Dash.app for the current word."
  (interactive)
  (let* ((myWord (thing-at-point 'symbol))
         (myUrl (concat "dash://" myWord)))
    (browse-url myUrl)))


;; haskell
;; =======

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(defun mjhoy/define-haskell-keys ()
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(defun mjhoy/define-haskell-cabal-keys ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-mode-hook 'mjhoy/define-haskell-keys)
(add-hook 'haskell-cabal-hook 'mjhoy/define-haskell-cabal-keys)


;; cc mode
;; =======

(setq c-default-style "linux"
      c-basic-offset 6)
(defun my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)

;; php
;; ===

;; drupal style conventions
(add-hook 'php-mode-hook 'php-enable-drupal-coding-style)

;; misc
;; ====

;; tags are case sensitive
(setq tags-case-fold-search nil)

;; ensure newline at end of file
(setq require-final-newline t)

;; no tabs
(setq-default indent-tabs-mode nil)

;; css/scss
(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

(mjhoy/load-init-file "bindings.el")
