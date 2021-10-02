(require 'haskell-mode)

(defun mjhoy/setup-haskell-mode ()
  "My setup for haskell-mode."
  (lsp)
  )

(add-hook 'haskell-mode-hook #'mjhoy/setup-haskell-mode)

(provide 'init-haskell)
