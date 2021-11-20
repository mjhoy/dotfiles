(require 'init-lsp)

(defun mjhoy/setup-go-mode ()
  "My setup for go-mode."
  (lsp)
  (yas-minor-mode)
  (add-hook 'before-save-hook #'lsp-format-buffer nil t)
  (setq-local tab-width 4)
  )

(add-hook 'go-mode-hook #'mjhoy/setup-go-mode)

(provide 'init-go)
