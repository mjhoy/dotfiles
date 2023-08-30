(require 'elm-mode)

(setq elm-format-on-save t)
(setq elm-sort-imports-on-save t)

(defun mjhoy/setup-elm ()
  "My setup for elm-mode."
  (eglot-ensure)
  )

(add-hook 'elm-mode-hook 'mjhoy/setup-elm)

(provide 'init-elm)
