;;;; init.el / @mjhoy

(setq user-full-name "Michael Hoy"
      user-mail-address "michael.john.hoy@gmail.com")

(add-to-list 'load-path "~/.emacs.d/site-lisp")

(setq backup-directory-alist
      (list (cons "."
                  (expand-file-name "backups"
                                    user-emacs-directory))))

(setq inhibit-splash-screen t)
(setq initial-major-mode 'org-mode)

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;; packages

(require 'package)
(package-initialize)

(dolist (repo '(("elpa"      . "http://tromey.com/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa"     . "http://melpa.org/packages/")))
  (add-to-list 'package-archives repo))

(defun mjhoy/package-install (name)
  "Refresh packages and install a package"
  (package-refresh-contents)
  (package-install name))

(defun mjhoy/install-package-unless-installed (name)
  "Install a package by name unless it is already installed."
  (or (package-installed-p name) (mjhoy/package-install name)))

(defun mjhoy/install-packages (&rest packages)
  "Ensure a list of packages is installed."
  (package-initialize)
  (condition-case nil
      (mapc 'mjhoy/install-package-unless-installed packages)
    (error (message "Couldn't install package, no network connection?"))))

(mjhoy/install-packages
 'inf-ruby
 'ruby-test-mode
 'helm
 'idomenu
 'ido-vertical-mode
 'smex
 'magit
 'scss-mode
 'org
 'restclient
 'haskell-mode
 'web-mode
 'php-mode
 'yaml-mode
 'rainbow-mode
 'projectile
 'flx-ido
 'flycheck
 'flycheck-haskell
 ;; themes
 'color-theme-sanityinc-tomorrow
 'tango-plus-theme
 'boron-theme
 )

(defun mjhoy/install-optional-packages ()
  "Install packages that may be highly dependent on my system"
  (interactive)
  (mjhoy/install-packages
   ;; php debugging
   'geben
   ))

;;; UI

(set-face-attribute 'default nil :family "Input Mono")
(set-face-attribute 'default nil :height 130)
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
(setq-default line-spacing 0.2)         ; input is a little tight,
                                        ; increase the line-spacing

(load-theme 'sanityinc-tomorrow-night t)
(defun mjhoy/light ()
  "switch to my light theme"
  (interactive)
  (load-theme 'tango-plus t))
(defun mjhoy/dark ()
  "switch to my dark theme"
  (interactive)
  (load-theme 'sanityinc-tomorrow-night t))
(defun mjhoy/bright ()
  "switch to my dark theme (bright)"
  (interactive)
  (load-theme 'sanityinc-tomorrow-bright t))
(defun mjhoy/boron ()
  "switch to boron theme"
  (interactive)
  (load-theme 'boron t))

(menu-bar-mode 0)
(when (string-equal system-type "darwin")
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (when (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

(setq scroll-conservatively 10000)
(show-paren-mode t)

;;; narrowing

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;;; windmove

(windmove-default-keybindings)

;; Make windmove work in org-mode
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;;; projectile

(projectile-global-mode)

;;; uniquify

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;; sensitive mode

;; see: http://anirudhsasikumar.net/blog/2005.01.21.html
(define-minor-mode sensitive-mode
  "Disable backup creation and auto saving."
  nil
  " Sensitive"
  nil
  (if (symbol-value sensitive-mode)
      (progn
        (set (make-local-variable 'backup-inhibited) t)
        (if auto-save-default
            (auto-save-mode -1)))
    (kill-local-variable 'backup-inhibited)
    (if auto-save-default
        (auto-save-mode 1))))

;;; opening files with sudo automatically

(defun sudo-find-file (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file)))
  (sensitive-mode))

;;; ido

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; mu4e

;; load config only if mu4e exists (my main laptop)
(let ((mu4e-path "/usr/local/share/emacs/site-lisp/mu4e"))
  (if (file-exists-p mu4e-path)
    (progn
      (add-to-list 'load-path mu4e-path)
      (load "mjhoy/mu4e"))))

(add-hook 'mu4e-compose-mode-hook
          (lambda ()
            (mjhoy/proportional)
            (set-fill-column 72)
            (flyspell-mode)))
(add-hook 'mu4e-view-mode-hook 'mjhoy/proportional)

;;; hippy expand

(setq hippie-expand-try-functions-list
      '(try-expand-all-abbrevs
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;;; flycheck

(add-hook 'scss-mode-hook #'flycheck-mode)
(add-hook 'js-mode-hook   #'flycheck-mode)
(add-hook 'c-mode-hook    #'flycheck-mode)
(add-hook 'haskell-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)

;;; org

(require 'org)
(add-to-list 'org-modules 'org-habit)

(setq org-agenda-files
      (list "~/Dropbox/org/organizer.org"
            "~/Dropbox/org/belch.org"
            "~/Dropbox/org/work.org"
            "~/Dropbox/org/dates.org"
            "~/Dropbox/org/projects.org"
            "~/Dropbox/org/daily.org"
            ))

(defun mjhoy/open-organizer ()
  (interactive)
  (find-file "~/Dropbox/org/organizer.org"))

(global-set-key (kbd "C-c o") 'mjhoy/open-organizer)

(setq org-default-notes-file "~/Dropbox/org/belch.org")

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/org/organizer.org" "General")
             "* TODO %?\n  %i\n  %a")
        ("n" "Note" entry (file "~/Dropbox/org/belch.org")
             "* %?\n%U\n%a")
        ("c" "Clock" item (clock)
             "%?\n%U\n%a")
        ("e" "Emacs config" entry (file+headline "~/Dropbox/org/belch.org" "emacs config")
             "* TODO %?\n%U\n%a")
        ("s" "Emacs tool sharpening" entry (file+olp "~/Dropbox/org/programming_notes.org"
                                                     "Emacs"
                                                     "Sharpening list")
             "* %?\nsee %a\nentered on %U")
        ("d" "Dream" entry (file+datetree "~/Dropbox/org/dream.org")
             "* %?\nEntered on %U")
        ("j" "Journal" plain (file+datetree "~/Dropbox/org/journal.org")
             "%?\nEntered on %U")))

(setq org-enforce-todo-dependencies t)
(setq org-log-done 'time)
(setq org-log-note-clock-out t)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;;; helm

(global-set-key (kbd "C-c h k") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h b") 'helm-buffers-list)

;;; magit

(global-set-key (kbd "C-c g") 'magit-status)

;;; scheme

(setq scheme-program-name "racket")

;;; ruby

(add-to-list 'auto-mode-alist '("Rakefile\\'"   . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'"    . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))

;;; javascript

(setq js-indent-level 2)

;;; haskell

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(defun mjhoy/define-haskell-keys ()
  (define-key haskell-mode-map (kbd "C-c C-c") 'haskell-compile))
(defun mjhoy/define-haskell-cabal-keys ()
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-compile))
(add-hook 'haskell-mode-hook 'mjhoy/define-haskell-keys)
(add-hook 'haskell-cabal-hook 'mjhoy/define-haskell-cabal-keys)

;;; c

(setq c-default-style "linux")
(setq c-basic-offset 6)
(defun my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)

;;; php and web-mode

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(add-hook 'php-mode-hook 'php-enable-drupal-coding-style)

;;; css/scss

(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

;;; project archetypes

(require 'project-archetypes)

;;; helpful commands

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

(defun mjhoy/ansi-term (&optional name)
  "Start a new bash ansi-term and ask for a name"
  (interactive (list (read-from-minibuffer "Buffer name: ")))
  (if (and name (not (string= "" name)))
      (ansi-term "/bin/bash" (concat name " ansi-term"))
    (ansi-term "/bin/bash")))

;;; misc

(setq-default indent-tabs-mode nil)
(setq require-final-newline t)
(setq tags-case-fold-search nil)

;;; bindings

(load "bindings")

;;; hmm

(setq c-default-style "linux")          ; For some reason I need to
                                        ; evaluate this code AFTER
                                        ; I've loaded php-mode once,
                                        ; or else php-mode doesn't
                                        ; work. (huh???)
