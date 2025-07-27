(require 'tramp)

;; disable auto save in tramp mode
(defun tramp-set-auto-save ()
  (auto-save-mode -1))

;; nixos compatibility
(add-to-list 'tramp-remote-path "/run/current-system/sw/bin")

(setopt tramp-default-method "ssh")

(provide 'init-tramp)
