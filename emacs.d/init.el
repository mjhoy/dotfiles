;;;; init.el / @mjhoy

(package-initialize)

(setq user-full-name "Michael Hoy"
      user-mail-address "mjh@mjhoy.com")

(defvar nixos (file-directory-p "/etc/nixos")
  "Are we running on nixos?")

(defvar macos (string-equal system-type "darwin")
  "Are we running on macos?")

(defvar macport (fboundp 'mac-file-alias-p)
  "Are we running macports Emacs?")

;; see: https://debbugs.gnu.org/cgi/bugreport.cgi?bug=25778
(if (and (getenv "DISPLAY") (executable-find "xdg-open"))
    (setq browse-url-browser-function 'browse-url-xdg-open))

(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path
             (expand-file-name "site-lisp" user-emacs-directory))

(let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
  (normal-top-level-add-subdirs-to-load-path))

;; save customizations in a different file (so they don't pollute
;; init.el.)
(setq custom-file
      (concat (expand-file-name user-emacs-directory) "custom.el"))
(load custom-file 'noerror)

;; this directory's subdirectories aren't added in osx gui emacs for
;; some reason.
(if (file-exists-p "/usr/local/share/emacs/site-lisp")
    (let ((default-directory "/usr/local/share/emacs/site-lisp"))
      (normal-top-level-add-subdirs-to-load-path)))

;; Prevent an odd TRAMP bug. Hangs at "Sending password" otherwise.
(add-hook 'after-init-hook
	  #'(lambda ()
	      (if (member "." load-path)
		  (delete "." load-path))))

;; Borg
(add-to-list 'load-path (expand-file-name "lib/borg" user-emacs-directory))
(require 'borg)
(borg-initialize)

(require 'init-basic)
(require 'init-local)
(require 'init-env)
(require 'init-diminish)
(require 'init-ui)
(require 'init-theme)
(require 'init-treesitter)
(require 'init-hl-line)
(require 'init-multiple-cursors)
(require 'init-prog)
(require 'init-markdown)
(require 'init-tramp)
(require 'init-org)
(require 'init-erc)
(require 'init-windmove)
(require 'init-winring)
(require 'init-compilation)
(require 'init-project)
(require 'init-which-key)
(require 'init-ibuffer)
(require 'init-dired)
(require 'init-uniquify)
(require 'init-mu4e)
(require 'init-yas)
(require 'init-sql)
(require 'init-flycheck)
(require 'init-flymake)
(require 'init-flyspell)
(require 'init-vertico)
(require 'init-marginalia)
(require 'init-orderless)
(require 'init-embark)
(require 'init-consult)
(require 'init-corfu)
(require 'init-cape)
(require 'init-magit)
(require 'init-lsp-booster)
(require 'init-eglot)
(require 'init-scheme)
(require 'init-ruby)
(require 'init-python)
(require 'init-rust)
(require 'init-javascript)
(require 'init-typescript)
(require 'init-svelte)
(require 'init-scala)
(require 'init-haskell)
(require 'init-c)
(require 'init-csharp)
(require 'init-go)
(require 'init-swift)
(require 'init-yaml)
(require 'init-protobuf)
(require 'init-gdk)
(require 'init-php)
(require 'init-web-mode)
(require 'init-xml)
(require 'init-css)
(require 'init-term)
(require 'init-gpt)
(require 'init-folding)
(require 'init-avy)
(require 'init-ledger)
(require 'init-dotfile-shortcuts)
(require 'init-presentation)
(require 'init-pass)
(require 'init-linear)
(require 'init-misc)
(require 'init-private nil 'noerror)
