(mjhoy/require-package 'rainbow-mode)
(mjhoy/require-package 'color-theme-sanityinc-tomorrow)
(mjhoy/require-package 'tango-plus-theme)

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

(provide 'init-theme)
