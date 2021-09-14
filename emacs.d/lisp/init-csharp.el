(require 'init-lsp)
(require 'lsp-csharp)

(defun mjhoy/setup-csharp-mode ()
  "My setup for csharp-mode."
  (lsp)
  )

(add-hook 'csharp-mode-hook #'mjhoy/setup-csharp-mode)

(provide 'init-csharp)