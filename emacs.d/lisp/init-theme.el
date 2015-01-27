(mjhoy/require-package 'rainbow-mode)
(mjhoy/require-package 'tango-plus-theme)

(defvar mjhoy/current-theme nil)

;; custom theme
(load "emacs-boron-theme-mjhoy/boron-theme")

(defun mjhoy/switch-theme (theme)
  "Disable currently loaded theme in mjhoy/current-theme,
  enable THEME and set as mjhoy/current-theme. This allows quick
  switching between two themes without color pollution. Assume
  THEME is ok to run lisp code."
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
			     (mapcar 'symbol-name
				     (custom-available-themes))))))
  (unless (custom-theme-name-valid-p theme)
    (error "Invalid theme name `%s'" theme))
  (if mjhoy/current-theme
      (disable-theme mjhoy/current-theme))
  (setq mjhoy/current-theme theme)
  (load-theme theme t))

(defun mjhoy/light ()
  "switch to my light theme"
  (interactive)
  (mjhoy/switch-theme 'tango-plus))

(defun mjhoy/dark ()
  "switch to my dark theme"
  (interactive)
  (mjhoy/switch-theme 'boron))

(mjhoy/dark)

(provide 'init-theme)
