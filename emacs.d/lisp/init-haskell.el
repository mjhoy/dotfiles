(require 'haskell-mode)
(require 'init-lsp)

(defun mjhoy/setup-haskell-mode ()
  "My setup for haskell-mode."
  (lsp)
  (add-hook 'before-save-hook #'lsp-format-buffer nil t)
  )

(add-hook 'haskell-mode-hook #'mjhoy/setup-haskell-mode)

(setq lsp-haskell-plugin-import-lens-code-lens-on nil)
(setq lsp-haskell-formatting-provider "fourmolu")

(provide 'init-haskell)
