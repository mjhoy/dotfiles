(mjhoy/require-package 'ensime)
(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(provide 'init-scala)
