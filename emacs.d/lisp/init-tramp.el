(require 'tramp)

;; disable auto save in tramp mode
(defun tramp-set-auto-save ()
  (auto-save-mode -1))

(setq tramp-default-method "ssh")

(provide 'init-tramp)
