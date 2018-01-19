(mjhoy/require-package 'rainbow-mode)   ; used for hacking on boron
(mjhoy/require-package 'tango-plus-theme)
(mjhoy/require-package 'material-theme) ; my main theme these days.
(mjhoy/require-package 'auto-dim-other-buffers)

(defvar mjhoy/current-theme nil
  "The current custom theme.")

(add-to-list 'custom-theme-load-path
             (expand-file-name "site-lisp/matsys-theme" user-emacs-directory))
(add-to-list 'custom-theme-load-path
             (expand-file-name "site-lisp/davy-theme" user-emacs-directory))

(defun mjhoy/switch-theme (theme)
  "Disable currently loaded theme in mjhoy/current-theme,
enable THEME and set as mjhoy/current-theme. This allows quick
switching between two themes without color pollution. Assume
THEME is ok to run lisp code.

If THEME is `original', disable all custom themes."
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
			     (append
                              (list 'original)
                              (mapcar 'symbol-name
                                      (custom-available-themes)))))))
  (if (eq 'original theme)
      (progn
        (setq mjhoy/current-theme nil)
        (mapcar 'disable-theme custom-enabled-themes))
    (unless (custom-theme-name-valid-p theme)
      (error "Invalid theme name `%s'" theme))
    (if mjhoy/current-theme
        (disable-theme mjhoy/current-theme))
    (setq mjhoy/current-theme theme)
    (load-theme theme t)))

(provide 'init-theme)
