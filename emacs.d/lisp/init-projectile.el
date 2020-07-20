(require 'counsel-projectile)

(setq projectile-keymap-prefix (kbd "C-c p"))

(projectile-global-mode)

(counsel-projectile-mode)

(defun mjhoy/projectile-is-drupal ()
  "Returns t if the current project is a drupal project, nil otherwise."
  (and (projectile-project-p)
       (let ((rt (projectile-project-root)))
         (and (projectile-file-exists-p (concat rt "index.php"))
              (projectile-file-exists-p (concat rt "sites/all"))
              (projectile-file-exists-p (concat rt "modules"))))))

(defun mjhoy/projectile-regenerate-tags (orig-fun &rest args)
  "Advice for `projectile-regenerate-tags', tweaks for project types.

If the current projectile project is a Drupal repository, adjust
`projectile-tags-command' to examine only php files, and tell
it about Drupal filename conventions (e.g., .inc, .module, etc)."
  (cond ((mjhoy/projectile-is-drupal)
         (let ((projectile-tags-command (concat
                                         "ctags -Re "
                                         "--langmap=php:.engine.inc.module.theme.install.php "
                                         "--php-kinds=cdfi "
                                         "--languages=php "
                                         "-f \"%s\" %s")))
           (message "Generating TAGS for Drupal, may take a sec...")
           (apply orig-fun '())
           (message "Done.")))
        (t (apply orig-fun '()))))

(advice-add 'projectile-regenerate-tags :around #'mjhoy/projectile-regenerate-tags)

(setq projectile-enable-caching t)

(setq projectile-completion-system 'ivy)

(defun mjhoy/projectile-init ()
  "My projectile initialization."

  ;; I don't like that projectile-ag doesn't take a regexp. And even
  ;; running it with C-u doesn't seem to work?
  (define-key projectile-mode-map (kbd "C-c p s s") #'ag-project-regexp)
  )

(add-hook 'projectile-mode-hook #'mjhoy/projectile-init)

(provide 'init-projectile)
