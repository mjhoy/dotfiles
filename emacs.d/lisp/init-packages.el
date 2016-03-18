(require 'package)

(setq package-archives '(("elpa"      . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")
                         ("org"       . "http://orgmode.org/elpa/")))

(setq package-menu-async nil)

(defun mjhoy/require-package (package)
  "Ensure PACKAGE is installed"
  (if (package-installed-p package)
      t
    (mjhoy/package-install package)))

(defun mjhoy/package-install (name)
  "Refresh packages and install a package"
  (package-refresh-contents)
  (package-install name))

(provide 'init-packages)
