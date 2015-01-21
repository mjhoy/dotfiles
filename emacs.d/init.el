;;;; init.el / @mjhoy

(setq user-full-name "Michael Hoy"
      user-mail-address "mjh@mjhoy.com")

(add-to-list 'load-path "~/.emacs.d/site-lisp")

(setq backup-directory-alist
      (list (cons "."
                  (expand-file-name "backups"
                                    user-emacs-directory))))

(setq inhibit-splash-screen t)

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
 'ibuffer-vc
 'idomenu
 'ido-vertical-mode
 'smex
 'company
 'magit
 'scss-mode
 'org
 'org-magit
 'restclient
 'haskell-mode
 'web-mode
 'php-mode
 'rust-mode
 'flycheck-rust
 'yaml-mode
 'projectile
 'helm-projectile
 'flx-ido
 'flycheck
 'flycheck-haskell
 'yasnippet
 'rainbow-mode
 ;; themes
 'color-theme-sanityinc-tomorrow
 'tango-plus-theme
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

(load "emacs-boron-theme-mjhoy/boron-theme")
(load-theme 'boron t)
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
(setq ring-bell-function 'ignore)

; find-file-at-point (replaces 'set-fill-column)
(global-set-key (kbd "C-x f") 'find-file-at-point)

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

;;; ibuffer

(require 'ibuffer-vc)
(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-vc-set-filter-groups-by-vc-root)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;; dired

(require 'dired)

(setq dired-listing-switches "-laGh")

(defun dired-get-size ()
  (interactive)
  (let ((files (dired-get-marked-files)))
    (with-temp-buffer
      (apply 'call-process "/usr/bin/du" nil t nil "-sch" files)
      (message
       "Size of all marked files: %s"
       (progn
         (re-search-backward "^\s?\\([0-9.,]+[A-Za-z]+\\).*total$")
         (match-string 1))))))

(define-key dired-mode-map (kbd "z") 'dired-get-size)

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

;;; company

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "M-SPC") 'company-complete)

;;; ido

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(require 'ido-vertical-mode)
(ido-vertical-mode 1)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "C-c s") 'idomenu)

;;; mu4e

(defvar mjhoy/mu4e-load-path
  "/usr/local/share/emacs/site-lisp/mu4e"
  "Load path for my mu4e install")

(defvar mjhoy/mu4e-exists-p
  (file-exists-p mjhoy/mu4e-load-path)
  "Whether mu4e exists on this system")

;; load config only if mu4e exists (my main laptop)
(if mjhoy/mu4e-exists-p
    (progn
      (add-to-list 'load-path mjhoy/mu4e-load-path)
      (load "mjhoy/mu4e")))

;;; yasnippet

(require 'yasnippet)
(yas-reload-all)

;; keep the following in case I turn on yas-global-mode
(add-hook 'term-mode-hook (lambda()     ; disable in term mode, yas
                (yas-minor-mode -1)))   ; interacts poorly with it for
                                        ; some reason

(add-hook 'php-mode-hook
          '(lambda ()
             (yas-minor-mode)))

;;; sql

(defun mjhoy/mysql-scratch ()
  "Create a new scratch buffer set up for mysql"
  (interactive)
  (let ((mysql-buffer (get-buffer-create "*mysql-scratch*")))
    (with-current-buffer mysql-buffer
      (sql-mode)
      (sql-highlight-mysql-keywords)
      (sql-set-sqli-buffer))
    (split-window-sensibly)
    (switch-to-buffer mysql-buffer)))

(defun mjhoy/postgres-scratch ()
  "Create a new scratch buffer set up for postgres"
  (interactive)
  (let ((postgres-buffer (get-buffer-create "*postgres-scratch*")))
    (with-current-buffer postgres-buffer
      (sql-mode)
      (sql-highlight-postgres-keywords)
      (sql-set-sqli-buffer))
    (split-window-sensibly)
    (switch-to-buffer postgres-buffer)))

;;; flycheck

(add-hook 'scss-mode-hook #'flycheck-mode)
(add-hook 'js-mode-hook   #'flycheck-mode)
(add-hook 'c-mode-hook    #'flycheck-mode)
(add-hook 'haskell-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-haskell-setup)
(add-hook 'rust-mode-hook #'flycheck-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

;;; org

(require 'org)

(setq org-directory "~/Dropbox/org/")

(setq org-agenda-files
      (mapcar
       (function (lambda (f) (concat org-directory f)))
       (list "organizer.org"            ; main work/life todos
             "belch.org"                ; all notes go here
             "dates.org"                ; upcoming dates
             "projects.org"             ; personal project notes
             )))

(defun mjhoy/open-organizer ()
  (interactive)
  (find-file (concat org-directory "organizer.org")))

(global-set-key (kbd "C-c o") 'mjhoy/open-organizer)

(setq org-default-notes-file (concat org-directory "belch.org"))

(setq org-capture-templates
      '(("t" "Todo"
         entry (file+headline (concat org-directory "organizer.org") "General")
         "* TODO %?\n  %i\n  %a")
        ("n" "Note"
         entry (file (concat org-directory "belch.org"))
         "* %?\n%U\n%a")
        ("c" "Clock" item (clock)
         "%?\n%U\n%a")
        ("q" "Clock (quick)" plain (clock)
         "%a%?")
        ("s" "Emacs tool sharpening"
         entry (file+olp (concat org-directory "programming_notes.org")
                         "Emacs"
                         "Sharpening list")
         "* %?\nsee %a\nentered on %U")
        ("d" "Date"
         entry (file+datetree+prompt (concat org-directory "dates.org"))
         "* %?\n%t\n\nsee %a")
        ("j" "Journal"
         plain (file+datetree (concat org-directory "journal.org"))
         "%?\nEntered on %U")))

(setq org-enforce-todo-dependencies t)
(setq org-log-done 'time)
(setq org-log-note-clock-out t)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

;; from https://lists.gnu.org/archive/html/emacs-orgmode/2012-02/msg00515.html
(defun org-summary-checkboxes ()
  "Switch entry to DONE when all sub-checkboxes are done, to TODO otherwise."
  (save-excursion
    (org-back-to-heading t)
    (let ((beg (point)) end)
      (end-of-line)
      (setq end (point))
      (goto-char beg)
      (if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]" end t)
          (if (match-end 1)
              (if (equal (match-string 1) "100%")
                  (org-todo 'done)
                (org-todo 'todo))
            (if (and (> (match-end 2) (match-beginning 2))
                     (equal (match-string 2) (match-string 3)))
                (org-todo 'done)
              (org-todo 'todo)))))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
(add-hook 'org-checkbox-statistics-hook 'org-summary-checkboxes)

(add-hook 'org-store-link-functions 'org-eww-store-link)
(defun org-eww-store-link ()
  "Store a link to the url of a eww buffer."
  (when (eq major-mode 'eww-mode)
    (org-store-link-props
     :type "eww"
     :link (if (< emacs-major-version 25)
               eww-current-url
             (eww-current-url))
     :url (url-view-url t)
     :description (if (< emacs-major-version 25)
                      (or eww-current-title eww-current-url)
                    (or (plist-get eww-data :title)
                        (eww-current-url))))))

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;;; helm

;; I want to use helm for as much as possible, but one issue is that
;; it crashes on OSX for large matching lists, see:
;; https://github.com/bbatsov/projectile/issues/600
;;
;; Until then I'll keep ido around as well.

(require 'helm)

(if mjhoy/mu4e-exists-p
    (progn
      ;; note: requires gnu-sed on osx
      ;; $ brew install gnu-sed --with-default-names
      ;; more at https://github.com/emacs-helm/helm-mu
      (add-to-list 'load-path "~/.emacs.d/site-lisp/helm-mu")
      (autoload 'helm-mu "helm-mu" "" t)
      (autoload 'helm-mu-contacts "helm-mu" "" t)))

(global-set-key (kbd "C-c h k") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h i") 'helm-imenu)
(global-set-key (kbd "C-c h j") 'helm-etags-select)
(global-set-key (kbd "C-c h f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-c h o") 'helm-org-in-buffer-headings)
(global-set-key (kbd "C-c h e") 'helm-mu)

;; old buffer switching
(global-set-key (kbd "C-c h b") 'switch-to-buffer)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; helm projectile integration

(require 'helm-projectile)
(global-set-key (kbd "C-c p h") 'helm-projectile)

;(helm-projectile-on)

;;; magit

(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-x g b") 'magit-blame-mode)

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

(add-to-list 'auto-mode-alist '("\\.module\\'" . php-mode))

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

;; (replaces 'describe-no-warranty)
(global-set-key (kbd "C-h C-w") 'mjhoy/lookup-apple-dictionary)

(defun mjhoy/lookup-dash ()
  "Query Dash.app for the current word."
  (interactive)
  (let* ((myWord (thing-at-point 'symbol))
         (myUrl (concat "dash://" myWord)))
    (browse-url myUrl)))

;; replaces 'view-emacs-debugging
(global-set-key (kbd "C-h C-d") 'mjhoy/lookup-dash)


(defun mjhoy/ansi-term (&optional name)
  "Start a new bash ansi-term and ask for a name"
  (interactive (list (read-from-minibuffer "Buffer name: ")))
  (if (and name (not (string= "" name)))
      (ansi-term "/bin/bash" (concat name " ansi-term"))
    (ansi-term "/bin/bash")))

(global-set-key (kbd "C-c t") 'mjhoy/ansi-term)

;;; misc

(setq-default indent-tabs-mode nil)
(setq require-final-newline t)
(setq tags-case-fold-search nil)

;; begone, crazy command
(global-unset-key (kbd "C-x C-u"))
(put 'upcase-region 'disabled nil)
