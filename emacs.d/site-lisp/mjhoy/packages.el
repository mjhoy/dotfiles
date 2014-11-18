;; Idea from Ryan Davis:
;; http://blog.zenspider.com/blog/2013/06/my-emacs-setup-packages.html

(require 'package)

(dolist (repo '(("elpa"      . "http://tromey.com/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa"     . "http://melpa.milkbox.net/packages/")))
  (add-to-list 'package-archives repo))

(defun jeg2/package-refresh-and-install (name)
  "Ensure we have a fresh package list, then install."
  (package-refresh-contents)
  (package-install name))

(defun jeg2/package-install-unless-installed (name)
  "Install a package by name unless it is already installed."
  (or (package-installed-p name) (jeg2/package-refresh-and-install name)))

(defun jeg2/package-details-for (name)
  (let ((v (cdr (assoc name package-archive-contents))))
    (and v (if (consp v)
	       (car v) ; emacs 24+
	     v))))

(defun jeg2/package-version-for (package)
  "Get the version of a loaded package."
  (package-desc-vers (jeg2/package-details-for package)))

(defun jeg2/package-delete-by-name (package)
  "Remove a package by name."
  (package-delete (symbol-name package)
                  (package-version-join (jeg2/package-version-for package))))

(defun jeg2/package-delete-unless-listed (packages)
  "Remove packages not explicitly declared."
  (let ((packages-and-dependencies (jeg2/packages-requirements packages)))
    (dolist (package (mapcar 'car package-alist))
      (unless (memq package packages-and-dependencies) (jeg2/package-delete-by-name package)))))

(defun jeg2/packages-requirements (packages)
  "List of dependencies for packages."
  (delete-dups (apply 'append (mapcar 'jeg2/package-requirements packages))))

(defun jeg2/flatten (x)
  "Flatten a list"
  (cond ((null x) nil)
        ((listp x) (append (jeg2/flatten (car x)) (jeg2/flatten (cdr x))))
        (t (list x))))

(defun jeg2/package-requirements (package)
  "List of recursive dependencies for a package."
  (let ((package-info (jeg2/package-details-for package)))
     (cond ((null package-info) (list package))
           (t
            (jeg2/flatten
             (cons package
                   (mapcar 'jeg2/package-requirements
                           (mapcar 'car (package-desc-reqs package-info)))))))))

(defun jeg2/package-install-and-remove-to-match-list (&rest packages)
  "Sync packages so the installed list matches the passed list."
  (package-initialize)
  (condition-case nil ;; added to handle no-network situations
      (mapc 'jeg2/package-install-unless-installed packages)
    (error (message "Couldn't install package. No network connection?")))
  (jeg2/package-delete-unless-listed packages))

(jeg2/package-install-and-remove-to-match-list
 'color-theme-sanityinc-tomorrow
 'tango-plus-theme
 'inf-ruby
 'ruby-test-mode
 'idomenu
 'ido-vertical-mode
 'magit
 'scss-mode
 'org
 'haskell-mode
 'php-mode
 'yaml-mode
 'twittering-mode
 'rainbow-mode
 'projectile
 'flx-ido
 'flycheck
 )
