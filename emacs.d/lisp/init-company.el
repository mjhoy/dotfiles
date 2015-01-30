(mjhoy/require-package 'company)

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "M-SPC") 'company-complete)
(setq company-idle-delay nil)

(provide 'init-company)
