;;;; init.el / @mjhoy

(package-initialize)

(setq user-full-name "Michael Hoy"
      user-mail-address "mjh@mjhoy.com")

;; are we running on nix?
(if (string-match "nixos" (system-name)) (setq nixos t) (setq nixos nil))

;; are we running on macos?
(if (string-equal system-type "darwin") (setq macos t) (setq macos nil))

;; see: https://debbugs.gnu.org/cgi/bugreport.cgi?bug=25778
(if (and (getenv "DISPLAY") (executable-find "xdg-open"))
    (setq browse-url-browser-function 'browse-url-xdg-open))

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
(require 'init-pbcopy)
(require 'init-theme)
(require 'init-hl-line)
(require 'init-prog)
(require 'init-tramp)
(require 'init-org)
(require 'init-erc)
(require 'init-windmove)
(require 'init-winring)
(require 'init-compilation)
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
(require 'init-markdown)
(require 'init-scheme)
(require 'init-ruby)
(require 'init-python)
(require 'init-rust)
(require 'init-javascript)
(require 'init-purescript)
(require 'init-haskell)
(require 'init-nix)
(require 'init-c)
(require 'init-nasm)
(require 'init-gdk)
(require 'init-php)
(require 'init-web-mode)
(require 'init-css)
(require 'init-coq)
(require 'init-ess)
(require 'init-project-archetypes)
(require 'init-term)
(require 'init-folding)
(require 'init-ace)
(require 'init-ledger)
(require 'init-dotfile-shortcuts)
(require 'init-presentation)
(require 'init-pass)
(require 'init-misc)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-paren-colors
   (quote
    ("#B9F" "#B8D" "#B7B" "#B69" "#B57" "#B45" "#B33" "#B11")))
 '(package-selected-packages
   (quote
    (markdown-mode zenburn-theme yasnippet yard-mode yaml-mode yafolding winring web-mode tango-plus-theme robe restclient rainbow-mode racer psci psc-ide php-mode pbcopy org-tree-slide org-plus-contrib org-mime nix-mode mu4e-maildirs-extension molokai-theme moe-theme material-theme magit ibuffer-vc helm-projectile helm-pass helm-dash helm-ag geiser flycheck-rust flycheck-haskell ess dracula-theme dired-details diminish company-racer company-ghci company-ghc color-theme-sanityinc-tomorrow bm auto-dim-other-buffers arjen-grey-theme apache-mode ag ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
