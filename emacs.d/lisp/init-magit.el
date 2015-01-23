(mjhoy/require-package 'magit)
(mjhoy/require-package 'org-magit)

(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-x g b") 'magit-blame-mode)

(provide 'init-magit)
