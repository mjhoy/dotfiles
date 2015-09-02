(mjhoy/require-package 'scss-mode)
(mjhoy/require-package 'rainbow-mode)

(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

(defun mjhoy/init-scss-mode ()
  (rainbow-mode 1))

(add-hook 'scss-mode-hook 'mjhoy/init-scss-mode)

(provide 'init-css)
