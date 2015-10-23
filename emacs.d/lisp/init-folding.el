(mjhoy/require-package 'yafolding)

(defun mjhoy/init-folding ()
  "Initiaize folding"
  (yafolding-mode 1))

(add-hook 'php-mode-hook 'mjhoy/init-folding)

(provide 'init-folding)
