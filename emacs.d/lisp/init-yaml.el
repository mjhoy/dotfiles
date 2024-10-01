(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-ts-mode))

(defun mjhoy/setup-yaml-mode ()
  "My custom yaml-mode setup."
  (yafolding-mode))

(add-hook 'yaml-ts-mode-hook #'mjhoy/setup-yaml-mode)

(provide 'init-yaml)
