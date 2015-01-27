(mjhoy/require-package 'rainbow-mode)
(mjhoy/require-package 'color-theme-sanityinc-tomorrow)
(mjhoy/require-package 'tango-plus-theme)

(defvar mjhoy/current-theme nil)

(load "emacs-boron-theme-mjhoy/boron-theme")
(load-theme 'boron t)
(setq mjhoy/current-theme 'boron)

(defun mjhoy/light ()
  "switch to my light theme"
  (interactive)
  (disable-theme mjhoy/current-theme)
  (setq mjhoy/current-theme 'tango-plus)
  (load-theme 'tango-plus t))

(defun mjhoy/dark ()
  "switch to my dark theme"
  (interactive)
  (disable-theme mjhoy/current-theme)
  (setq mjhoy/current-theme 'sanityinc-tomorrow-night)
  (load-theme 'sanityinc-tomorrow-night t))

(defun mjhoy/bright ()
  "switch to my dark theme (bright)"
  (interactive)
  (disable-theme mjhoy/current-theme)
  (setq mjhoy/current-theme 'sanityinc-tomorrow-bright)
  (load-theme 'sanityinc-tomorrow-bright t))

(defun mjhoy/boron ()
  "switch to boron theme"
  (interactive)
  (disable-theme mjhoy/current-theme)
  (setq mjhoy/current-theme 'boron)
  (load-theme 'boron t))

(provide 'init-theme)
