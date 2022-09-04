(require 'haskell-mode)
(require 'init-lsp)

(defun mjhoy/setup-haskell-mode ()
  "My setup for haskell-mode."
  (lsp)
  )

(add-hook 'haskell-mode-hook #'mjhoy/setup-haskell-mode)

(setq lsp-haskell-plugin-import-lens-code-lens-on nil)
(setq lsp-haskell-formatting-provider "brittany")

(provide 'init-haskell)
