(require 'haskell-mode)
(require 'init-lsp)

(defun mjhoy/setup-haskell-mode ()
  "My setup for haskell-mode."
  (lsp)
  (add-hook 'after-save-hook #'mjhoy/format-haskell-on-save nil t)
  )

(add-hook 'haskell-mode-hook #'mjhoy/setup-haskell-mode)

(setq lsp-haskell-plugin-import-lens-code-lens-on nil)
(setq lsp-haskell-formatting-provider "brittany")

(defun mjhoy/format-haskell-on-save ()
  "Function to format a haskell buffer with brittany on save."
  (when (eq major-mode 'haskell-mode) ; ensure haskell-mode
    (shell-command-to-string (format "brittany --write-mode inplace %s" buffer-file-name))
    (revert-buffer :ignore-auto :noconfirm)))

(provide 'init-haskell)
