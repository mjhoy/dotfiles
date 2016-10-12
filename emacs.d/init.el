;;;; init.el / @mjhoy

(package-initialize)

(setq user-full-name "Michael Hoy"
      user-mail-address "mjh@mjhoy.com")

;; are we running on nix?
(if (string-match "^mjh-nix" (system-name)) (setq nixos t) (setq nixos nil))

;; we want to use a newer version of tramp to fix this bug:
;; https://lists.gnu.org/archive/html/bug-gnu-emacs/2015-01/msg00985.html
(add-to-list 'load-path
             (expand-file-name "tramp-git/lisp" user-emacs-directory))

(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path
             (expand-file-name "site-lisp" user-emacs-directory))

(let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
  (normal-top-level-add-subdirs-to-load-path))

;; if emacs lisp code exists in a nix-profile, add to load path. this
;; allows e.g., nix-env -iA nixpkgs.emacs24Packages.proofgeneral
(let ((nix-emacs-lisp-dir
       (expand-file-name "~/.nix-profile/share/emacs/site-lisp")))
  (if (file-exists-p nix-emacs-lisp-dir)
      (setq load-path (append (list nix-emacs-lisp-dir) load-path))))

;; this directory's subdirectories aren't added in osx gui emacs for
;; some reason.
(if (file-exists-p "/usr/local/share/emacs/site-lisp")
    (let ((default-directory "/usr/local/share/emacs/site-lisp"))
      (normal-top-level-add-subdirs-to-load-path)))

;; Prevent an odd TRAMP bug. Hangs at "Sending password" otherwise.
(add-hook 'after-init-hook
	  '(lambda ()
	     (if (member "." load-path)
		 (delete "." load-path))))

(require 'init-basic)
(require 'init-packages)
(require 'init-local)
(require 'init-env)
(require 'init-diminish)
(require 'init-ui)
(require 'init-theme)
(require 'init-prog)
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
(require 'init-flyspell)
(require 'init-helm)
(require 'init-magit)
(require 'init-restclient)
(require 'init-scheme)
(require 'init-ruby)
(require 'init-python)
(require 'init-rust)
(require 'init-javascript)
(require 'init-haskell)
(require 'init-nix)
(require 'init-c)
(require 'init-nasm)
(require 'init-gdk)
(require 'init-php)
(require 'init-web-mode)
(require 'init-css)
(require 'init-coq)
(require 'init-project-archetypes)
(require 'init-term)
(require 'init-folding)
(require 'init-ace)
(require 'init-ledger)
(require 'init-dotfile-shortcuts)
(require 'init-presentation)
(require 'init-pass)
(require 'init-misc)
