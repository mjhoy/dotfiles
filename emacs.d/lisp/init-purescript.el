(mjhoy/require-package 'psc-ide)

(defun mjhoy/purescript-mode-setup ()
  "Run to set up purescript mode."
  (psc-ide-mode)
  (flycheck-mode)
  (turn-on-purescript-indentation))

(add-hook 'purescript-mode-hook 'mjhoy/purescript-mode-setup)

(provide 'init-purescript)
