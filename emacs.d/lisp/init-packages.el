(require 'package)
(package-initialize)

(dolist (repo '(("elpa"      . "http://tromey.com/elpa/")
                ("marmalade" . "http://marmalade-repo.org/packages/")
                ("melpa"     . "http://melpa.org/packages/")))
  (add-to-list 'package-archives repo))

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
