(require 'sensitive-mode)
(require 'mjhoy-misc)

;; (replaces 'describe-no-warranty)
(global-set-key (kbd "C-h C-w") 'mjhoy/lookup-apple-dictionary)

;; replaces 'view-emacs-debugging
(global-set-key (kbd "C-h C-d") 'mjhoy/lookup-dash)

(provide 'init-misc)
