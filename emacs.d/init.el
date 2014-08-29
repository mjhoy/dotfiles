;; ❄ emacs setup ❄

(defvar config-dir (file-name-directory (or (buffer-file-name) load-file-name))
  "Path to the configuration directory (usually ~/.emacs.d)")

;; set up load path
(add-to-list 'load-path config-dir)
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

;; hello
(setq user-full-name "Michael Hoy"
      user-mail-address "michael.john.hoy@gmail.com")

;; packages
(load "mjhoy/packages")

;; keep backups under ~/.emacs.d
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backups" user-emacs-directory))))

;; interface
;; =========

;; gui only
(set-face-attribute 'default nil :family "Input Mono")
(set-face-attribute 'default nil :height 130)

;; Input is a bit tight, increase line-spacing
(setq-default line-spacing 0.2)

;; no menu bar
(menu-bar-mode 0)

;; no splash screen
(setq inhibit-splash-screen t)

;; other color themes:
;;   sanity-inc-tomorrow-night (/day/bright)
(load-theme 'tango-plus t)

;; show matching parens
(show-paren-mode t)

;; utf-8
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; don't jump the screen
(setq scroll-conservatively 10000)

;; projectile
(projectile-global-mode)

;; enable advanced emacs commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

(defun mjhoy/proportional ()
  "Use a proportional font"
  (interactive)
  (setq buffer-face-mode-face '(:family "Input Sans" :height 130))
  (buffer-face-mode))

(defun mjhoy/mono ()
  "Use a monospace font"
  (interactive)
  (setq buffer-face-mode-face '(:family "Input Mono" :height 130))
  (buffer-face-mode))

;; compose/view setup.
;; use proportional font (Input Sans) in email/twitter.
(add-hook 'mu4e-compose-mode-hook
          (lambda ()
            (mjhoy/proportional)
            (set-fill-column 72)
            (flyspell-mode)))
(add-hook 'mu4e-view-mode-hook 'mjhoy/proportional)
(add-hook 'twittering-mode-hook 'mjhoy/proportional)

;; disable scrollbars and menu bar on the mac. On Linux you can disable it in
;; Xdefaults.
(when (string-equal system-type "darwin")
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (when (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

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

(setq org-agenda-files
      (list "~/org/organizer.org"
            "~/org/belch.org"
            "~/org/class.org"
            "~/org/work.org"
            "~/org/daily.org"))

;; org captures
(setq org-default-notes-file "~/org/belch.org")

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/organizer.org" "General")
             "* TODO %?\n  %i\n  %a")
        ("n" "Note" entry (file "~/org/belch.org")
             "* %?\n%U\n%a")
        ("c" "Clock" item (clock)
             "%?\n%U\n%a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
             "* %?\nEntered on %U\n%i\n%a")))

;; (directory-files (expand-file-name "~/org") t ".*.org$")

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

;; mu4e
;; ====

(require 'mu4e)
(setq mu4e-maildir "~/.mail/michael.john.hoy-gmail.com")
(setq mu4e-drafts-folder "/drafts")
(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)))
(setq mu4e-get-mail-command "offlineimap -q -f INBOX")
;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)
(setq message-send-mail-function 'smtpmail-send-it
     starttls-use-gnutls t
     smtpmail-starttls-credentials
     '(("smtp.gmail.com" 587 nil nil))
     smtpmail-default-smtp-server "smtp.gmail.com"
     smtpmail-smtp-server "smtp.gmail.com"
     smtpmail-auth-credentials
     (expand-file-name "~/.authinfo.gpg")
     smtpmail-smtp-service 587)
(setq message-kill-buffer-on-exit t)
(setq mu4e-compose-signature-auto-include nil)
;; rich text messages
(setq mu4e-html2text-command "html2text -utf8 -nobs -width 72")
;; bookmarks
(add-to-list 'mu4e-bookmarks '("date:14d..now AND maildir:/archive"  "Latest archive" ?a))
(add-to-list 'mu4e-bookmarks '("date:14d..now AND maildir:/sent"     "Latest sent"    ?s))
(add-to-list 'mu4e-bookmarks '("size:5M..500M"                       "Big messages"   ?b))

(setq mu4e-attachment-dir  "~/Downloads")

;; twittering
;; ==========

(require 'twittering-mode)
(setq twittering-use-master-password t)

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

(load "bindings")
