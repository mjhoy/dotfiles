(require 'scala-mode)
(require 'sbt-mode)

;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
(setq sbt:program-options '("-Dsbt.supershell=false"))

(add-to-list 'auto-mode-alist '("\\.s\\(cala\\|bt\\)$" . scala-mode))

(defun mjhoy/setup-scala-mode ()
  "My setup for scala-mode."
  ;; No-op. For now, we're not loading lsp and lsp-metals due to:
  ;; https://github.com/emacs-lsp/lsp-metals/issues/81
  )

(add-hook 'scala-mode-hook 'mjhoy/setup-scala-mode)

(provide 'init-scala)
