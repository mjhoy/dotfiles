(mjhoy/require-package 'projectile)
(mjhoy/require-package 'ag)

(projectile-global-mode)

(setq projectile-enable-caching t)

(setq projectile-completion-system 'helm)

(provide 'init-projectile)
