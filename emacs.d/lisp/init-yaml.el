(defun mjhoy/setup-yaml-mode ()
  "My custom yaml-mode setup."
  (yafolding-mode))

(add-hook 'yaml-mode-hook #'mjhoy/setup-yaml-mode)

(provide 'init-yaml)
