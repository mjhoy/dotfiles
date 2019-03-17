(require 'ensime)

;; add the following to ~/.sbt/1.0/plugins/plugins.sbt:
;;
;; addSbtPlugin("org.ensime" % "sbt-ensime" % "2.5.1")

(setq ensime-eldoc-hints 'all)
(setq ensime-typecheck-when-idle nil)

(defun mjhoy/setup-scala-mode ()
  "My setup for scala-mode."
  (ensime-mode))

(add-hook 'scala-mode-hook 'mjhoy/setup-scala-mode)

(provide 'init-scala)
