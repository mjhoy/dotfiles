(defun mjhoy/load-init-file (path &optional noerror)
  "Load a file from the ~/.emacs.d directory."
  (let ((file (file-name-sans-extension
	       (expand-file-name path user-emacs-directory))))
    (load file noerror)))

;; required for inf-ruby??
(require 'thingatpt)

;; backups under ~/.emacs.d
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backups" user-emacs-directory))))

;; no menu bar
(menu-bar-mode 0)

;; no splash screen
(setq inhibit-splash-screen t)

(mjhoy/load-init-file "mjhoy/packages.el")
(mjhoy/load-init-file "mjhoy/commands.el")

;; theme
;;(load-theme 'zenburn t)
;;(require 'color-theme-sanityinc-tomorrow)
(load-theme 'sanityinc-tomorrow-bright t)

;; line number format: add a space
(setq linum-format "%d ")

;; begone, crazy command
(global-unset-key (kbd "C-x C-u"))

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Ruby file extensions/naming
(add-to-list 'auto-mode-alist '("Rakefile\\'"   . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'"    . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))

;; hippy expand!
(setq hippie-expand-try-functions-list
      '(try-expand-all-abbrevs
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))
(global-set-key "\M- " 'hippie-expand)
(setq user-mail-address "michael.john.hoy@gmail.com")

;; org mode
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-agenda-files (list "~/org/class.org"
			     "~/org/work.org"
			     "~/org/daily.org"))

;; scss
(setq scss-compile-at-save nil)

;; no tabs
(setq-default indent-tabs-mode nil)

;; haskell mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(defun mjhoy/define-haskell-keys ()
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(defun mjhoy/define-haskell-cabal-keys ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-mode-hook 'mjhoy/define-haskell-keys)
(add-hook 'haskell-cabal-hook 'mjhoy/define-haskell-cabal-keys)

;; ensure newline at end of file
(setq require-final-newline t)

;; cc-mode
(setq c-default-style "linux"
      c-basic-offset 6)
(defun my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)
