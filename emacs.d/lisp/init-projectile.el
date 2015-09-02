(mjhoy/require-package 'projectile)
(mjhoy/require-package 'ag)

(projectile-global-mode)

(defun mjhoy/projectile-is-drupal ()
  "Returns t if the current project is a drupal project, nil otherwise."
  (and (projectile-project-p)
       (let ((rt (projectile-project-root)))
         (and (projectile-file-exists-p (concat rt "index.php"))
              (projectile-file-exists-p (concat rt "sites/all"))
              (projectile-file-exists-p (concat rt "modules"))))))

; Disable for the time being as it creates problems with TRAMP
;(setq projectile-enable-caching t)

(setq projectile-completion-system 'helm)

(provide 'init-projectile)
