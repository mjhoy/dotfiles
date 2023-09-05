(defun mjhoy/setup-csharp-mode ()
  "My setup for csharp-mode."
  (eglot-ensure)
  (add-hook 'after-save-hook #'eglot-format-buffer nil t)
  )

(add-hook 'csharp-mode-hook #'mjhoy/setup-csharp-mode)

(provide 'init-csharp)
