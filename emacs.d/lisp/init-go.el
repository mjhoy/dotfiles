(defun mjhoy/setup-go-mode ()
  "My setup for go-mode."
  (eglot-ensure)
  (yas-minor-mode)
  (add-hook 'before-save-hook #'eglot-format-buffer nil t)
  (setq-local tab-width 4)
  )

(add-hook 'go-mode-hook #'mjhoy/setup-go-mode)

(provide 'init-go)
