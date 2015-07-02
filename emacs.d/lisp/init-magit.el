(setq magit-last-seen-setup-instructions "1.4.0")

(mjhoy/require-package 'magit)
(require 'org-magit)

(global-set-key (kbd "C-c g") 'magit-status)

(provide 'init-magit)
