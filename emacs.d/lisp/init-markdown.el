(require 'markdown-mode)

(defun mjhoy/setup-markdown-mode ()
  "My setup for markdown-mode."
  (auto-fill-mode 1)
  )

(add-hook 'markdown-mode-hook #'mjhoy/setup-markdown-mode)

(provide 'init-markdown)
