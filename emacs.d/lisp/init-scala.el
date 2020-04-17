(require 'scala-mode)
(require 'sbt-mode)
(require 'init-lsp)

;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
(setq sbt:program-options '("-Dsbt.supershell=false"))

(add-to-list 'auto-mode-alist '("\\.s\\(cala\\|bt\\)$" . scala-mode))

(defun mjhoy/setup-scala-mode ()
  "My setup for scala-mode."
  (lsp))

(add-hook 'scala-mode-hook 'mjhoy/setup-scala-mode)

(provide 'init-scala)
