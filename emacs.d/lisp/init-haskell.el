; TODO: remove when haskell-mode is updated.
; https://github.com/haskell/haskell-mode/pull/1828
(require 'flymake-proc)
(require 'haskell-mode)

(defun mjhoy/setup-haskell-mode ()
  "My setup for haskell-mode."
  (eglot-ensure)
  (add-hook 'before-save-hook #'eglot-format-buffer nil t)
  )

(add-hook 'haskell-mode-hook #'mjhoy/setup-haskell-mode)

(provide 'init-haskell)
