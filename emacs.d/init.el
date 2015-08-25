;;;; init.el / @mjhoy

(setq user-full-name "Michael Hoy"
      user-mail-address "mjh@mjhoy.com")

;; are we running on nix?
(if (equal (system-name) "nixos") (setq nixos t) (setq nixos nil))

(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path
             (expand-file-name "site-lisp" user-emacs-directory))

;; this directory isn't added in osx gui emacs for some reason.
(if (not (member "/usr/local/share/emacs/site-lisp" load-path))
    (let ((default-directory "/usr/local/share/emacs/site-lisp"))
      (normal-top-level-add-subdirs-to-load-path)))

(require 'init-basic)
(require 'init-packages)
(require 'init-diminish)
(require 'init-ui)
(require 'init-golden-ratio)
(require 'init-theme)
(require 'init-tramp)
(require 'init-org)
(require 'init-erc)
(require 'init-windmove)
(require 'init-projectile)
(require 'init-ibuffer)
(require 'init-dired)
(require 'init-uniquify)
(require 'init-company)
(require 'init-mu4e)
(require 'init-yas)
(require 'init-sql)
(require 'init-flycheck)
(require 'init-helm)
(require 'init-magit)
(require 'init-restclient)
(require 'init-scheme)
(require 'init-ruby)
(require 'init-rust)
(require 'init-javascript)
(require 'init-haskell)
(require 'init-nix)
(require 'init-c)
(require 'init-nasm)
(require 'init-php)
(require 'init-web-mode)
(require 'init-css)
(require 'init-project-archetypes)
(require 'init-term)
(require 'init-ace)
(require 'init-dotfile-shortcuts)
(require 'init-misc)
