(mjhoy/require-package 'psc-ide)

(defun mjhoy/purescript-mode-setup ()
  "Run to set up purescript mode."
  (psc-ide-mode)
  (flycheck-mode)
  (turn-on-purescript-indent)
  (turn-on-purescript-decl-scan)
  )

(add-hook 'purescript-mode-hook 'mjhoy/purescript-mode-setup)

(setq psc-ide-use-npm-bin t)
(setq psc-ide-use-purs nil)

(provide 'init-purescript)
