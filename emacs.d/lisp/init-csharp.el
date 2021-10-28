(require 'init-lsp)
(require 'lsp-csharp)

(defun mjhoy/setup-csharp-mode ()
  "My setup for csharp-mode."
  (lsp)
  (add-hook 'after-save-hook #'lsp-format-buffer nil t)
  (local-set-key (kbd "C-c C-t") #'lsp-csharp-run-test-at-point)
  (local-set-key (kbd "C-c M-t") #'lsp-csharp-run-all-tests-in-buffer)
  )

(add-hook 'csharp-mode-hook #'mjhoy/setup-csharp-mode)

(provide 'init-csharp)
