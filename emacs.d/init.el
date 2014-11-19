;; This file simply loads org mode to read my full configuration
;; file, which is emacs.org.
(package-initialize)
(require 'ob-tangle)
(org-babel-load-file "~/.emacs.d/emacs.org")

