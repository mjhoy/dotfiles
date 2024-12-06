(require 'scala-ts-mode)
(require 'sbt-mode)
(require 'init-eglot)

;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
(setq sbt:program-options '("-Dsbt.supershell=false"))

(add-to-list 'eglot-server-programs
             '((scala-ts-mode) "metals" ))

(defun mjhoy/setup-scala-ts-mode ()
  "My setup for scala-ts-mode."
  (eglot-ensure)
  (add-hook 'before-save-hook #'eglot-format-buffer nil t)
  ;; (add-hook 'before-save-hook #'mjhoy/eglot-organize-imports 5 t)
  )

(add-hook 'scala-ts-mode-hook 'mjhoy/setup-scala-ts-mode)

(provide 'init-scala)
