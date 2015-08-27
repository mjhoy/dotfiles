(mjhoy/require-package 'projectile)
(mjhoy/require-package 'ag)

(projectile-global-mode)

; Disable for the time being as it creates problems with TRAMP
;(setq projectile-enable-caching t)

(setq projectile-completion-system 'helm)

(provide 'init-projectile)
