(setq magit-last-seen-setup-instructions "1.4.0")

(mjhoy/require-package 'magit)
(require 'org-magit)

(setq magit-push-always-verify nil)

(global-set-key (kbd "C-c g") 'magit-status)

(provide 'init-magit)
